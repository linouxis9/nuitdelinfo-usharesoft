# *Nuit de l'Info 2018*

*[Nuit de l'Info 2018](https://www.nuitdelinfo.com/)*

Nous avons développé un mini programme en Rust s'occupant d'automatiquement généré une image à partir d'une template UForge et de télécharger celle-ci.

## Déploiement

### Prérequis

- Un compte UForge
- hammr
- Un hébergeur cloud, une platforme de container (docker ou LXC) ou une machine virtuelle.

### Préparation

- Création du fichier contenant vos identifiants UForge dans ~/.hammr/credentials.json

```json
{
  "user" : "root",
  "password" : "password",
  "url" : "https://uforge.usharesoft.com/api"
}
```
- Création de l'image à partir de la template.

- Déploiement de l'image.

### L'outil mydefi Rust

Une version précompilée de notre logiciel est disponible dans le dossier courant sous le nom mydefi, les sources sont compilable avec cargo et sont disponible dans le dossier defi.

```bash
./mydefi
./mydefi auto
```

Si vous compilez l'outil à partir des sources :

```bash
cd defi
cargo run auto
```

## Accéder au site Web

Une fois le site deployé, vous pourrez accéder à l'application web en accédant (http://IP_DU_SERVEUR/nuitinfo)

L'utilisateur par défaut est `gervasin` et le mot de passe associé `gervasin`.

## Remerciements
* [Nuit de l'Info 2018](https://www.nuitdelinfo.com/) - Pour ce concours
* [UShareSoft](https://www.usharesoft.com) - Pour ce défi et UForge
