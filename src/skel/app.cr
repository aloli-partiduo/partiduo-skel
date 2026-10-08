# SPDX-License-Identifier: AGPL-3.0-or-later

require "./manifest"
require "./models/**"
require "./services/**"
require "./api/**"

# Extension de référence de Partiduo (ADR-003 D8), successeur de l'extension
# `SKEL` de l'application d'origine. Même plan qu'une application du
# cœur (DECISIONS C1) : `manifest.cr`, `models/`, `migrations/`, `services/`
# (interne), `api/` (contrat public `Skel::Api`), `locales/`.
module Skel
  # Lue à la compilation dans `shard.yml`, seule source du numéro : chaque
  # commit y incrémente le dernier chiffre.
  VERSION = {{
              (read_file("#{__DIR__}/../../shard.yml")
                .lines
                .find(&.starts_with?("version:")) || "version: 0.0.0")
                .gsub(/^version:\s*/, "")
                .chomp
            }}

  # Code du registre (ADR-003 D2) : `skel` dans `PARTIDUO_MODULES`.
  CODE = "SKEL"

  # Application Marten du métier : modèles (tables `skel_*`), migrations et
  # libellés.
  class App < Marten::App
    label "skel"
  end

  # Applications Marten du métier, à ajouter à `installed_apps` de la
  # distribution après `Partiduo::INSTALLED_APPS`.
  INSTALLED_APPS = [Skel::App] of Marten::Apps::Config.class
end
