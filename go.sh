#!/bin/bash

# Fonction pour vérifier la version actuelle de Go
verifier_version_go() {
    if command -v go &> /dev/null; then
        go_version=$(go version)
        echo "La version actuelle de Go est : $go_version"
    else
        echo "Go n'est pas installé."
        go_version=""
    fi
}

# Fonction pour demander la désinstallation de la version actuelle de Go
desinstaller_go() {
    read -p "Voulez-vous supprimer la version actuelle de Go ? (oui/non) " reponse
    if [[ "$reponse" == "oui" ]]; then
        sudo rm -rf /usr/local/go
        echo "La version actuelle de Go a été supprimée."
    else
        echo "La version actuelle de Go n'a pas été supprimée."
    fi
}

# Fonction pour afficher le menu et installer une version spécifique de Go
installer_go() {
    echo "Sélectionnez la version de Go à installer :"
    select version in "1.18.10" "1.19.9" "1.20.8" "1.21.5" "1.22.2"; do
        case $version in
            1.18.*|1.19.*|1.20.*|1.21.*|1.22.*)
                echo "Téléchargement de Go version $version..."
                wget https://golang.org/dl/go$version.linux-amd64.tar.gz -O /tmp/go$version.linux-amd64.tar.gz
                sudo tar -C /usr/local -xzf /tmp/go$version.linux-amd64.tar.gz
                echo "Installation de Go version $version terminée."
                export PATH=$PATH:/usr/local/go/bin
                break
                ;;
            *)
                echo "Sélection non valide. Veuillez réessayer."
                ;;
        esac
    done
}

# Exécution principale du script
verifier_version_go

if [[ -n "$go_version" ]]; then
    desinstaller_go
fi

installer_go

# Vérification de l'installation
echo "Vérification de la version installée de Go :"
go version

# Message de fin
echo "Voilà petit PD, Go est installé avec succès."
