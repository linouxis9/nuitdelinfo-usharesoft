extern crate clap;

use clap::{AppSettings, App, SubCommand};
use std::process::Command;

extern crate tar;
extern crate flate2;

use std::fs::File;
use flate2::Compression;
use flate2::write::GzEncoder;
use std::io::Write;

extern crate regex;

use regex::Regex;


fn main() {
    let matches = App::new("UForge Builder and Downloader for Nuit de l'Info")
                          .version("1.0")
                          .author("Valentin D. <valentin@devling.xyz>")
                          .about("Builds our UForge template and download it")
                          .subcommand(SubCommand::with_name("auto")
                               .about("Build, download our template")
                               .help("Build and download automagically our template"))
                          .setting(AppSettings::SubcommandRequiredElseHelp)
                          .get_matches();

    if let Some(_) = matches.subcommand_matches("auto") {
        auto();
    }
}

fn auto() {
    let template = Template::new_from_json("template.json");
    let image = template.build().expect("La construction de l'image a echoué...");
    image.download();
}

struct Template {
    path: String,
}

impl Template {
    fn new_from_json(path: &str) -> Template {
        let path = String::from(path);
        let tar = File::create(path.replace("json", "tar.gz")).unwrap();

        let gz = GzEncoder::new(tar, Compression::default());
        let mut tar_gz = tar::Builder::new(gz);

        let _ = tar_gz.append_file(&path, &mut File::open(&path).unwrap());
        let _ = tar_gz.append_dir_all("config", "config");

        let _ = tar_gz.into_inner().unwrap().flush();

        let mut command = CommandGenerator::new(HammrCommand::Template, HammrSubcommand::Import);
        command.append_parameter(HammrParameter::File(path.replace("json", "tar.gz")));
        command.run();  

        Template { path }
    }

    fn build(&self) -> Option<Image> {
        let mut command = CommandGenerator::new(HammrCommand::Template, HammrSubcommand::Build);
        command.append_parameter(HammrParameter::File(self.path.clone()));
        let output = command.run();
        let pattern = Regex::new(r"Image Id : (\d*)").unwrap();
        
        for cap in pattern.captures_iter(&output) {
            return Some(Image::new(self.path.clone(), cap.get(1).expect("L'ID de l'image est invalide.").as_str().parse().unwrap()));
        }

        return None;
    }
}

struct Image {
    path: String,
    id: u32
}

impl Image {
    fn new(path: String, id: u32) -> Image {
        return Image { path, id }
    }

    fn download(&self) {
        let mut command = CommandGenerator::new(HammrCommand::Image, HammrSubcommand::Download);
        command.append_parameter(HammrParameter::File(String::from("image.iso")));
        command.append_parameter(HammrParameter::Id(self.id));
        let output = command.run();
        println!("{}", output);
    }
}
enum HammrCommand {
    Template,
    Image
}

impl HammrCommand {
    fn to_string(&self) -> &str{
        match &self {
            HammrCommand::Template => "template",
            HammrCommand::Image => "image"
        }
    }
}

enum HammrSubcommand {
    Build,
    Import,
    Download
}

impl HammrSubcommand {
    fn to_string(&self) -> &str {
        match &self {
            HammrSubcommand::Build => "build",
            HammrSubcommand::Import => "import",
            HammrSubcommand::Download => "download",
        }
    }
}

enum HammrParameter {
    File(String),
    Id(u32)
}

impl HammrParameter {
    fn to_string(&self) -> String {
        match &self {
            HammrParameter::File(value) => format!("--file {}",value),
            HammrParameter::Id(value) => format!("--id {}",value)
        }     
    }
}

struct CommandGenerator {
    command: HammrCommand,
    subcommand: HammrSubcommand,
    parameters: Vec<HammrParameter>
}

impl CommandGenerator {
    fn new(command: HammrCommand, subcommand: HammrSubcommand) -> CommandGenerator {
        CommandGenerator { command, subcommand, parameters: Vec::new()}
    }

    fn run(&self) -> String {
        let mut command = Command::new("hammr");
        command.arg(&self.command.to_string()).arg(&self.subcommand.to_string());

        for parameter in &self.parameters {
            for param in parameter.to_string().split(" ") {
                command.arg(param);
            }
        }
        println!("{:?}", command);
        let output = command.output().unwrap();
        println!("{:?}", output);
        String::from_utf8_lossy(&output.stdout).into_owned()
    }

    fn append_parameter(&mut self, parameter: HammrParameter) {
        &self.parameters.push(parameter);
    }
}