# Git Aliases
[heading__top]:
  #git-aliases
  "&#x2B06; Collection of scripts for Git aliasing"


Collection of scripts for Git aliasing


## [![Byte size of Git Utilitiesgithubio][badge__main__link_alias__source_code]][aliases__main__source_code] [![Open Issues][badge__issues__link_alias]][issues__link_alias] [![Open Pull Requests][badge__pull_requests__link_alias]][pull_requests__link_alias] [![Latest commits][badge__commits__link_alias__main]][commits__link_alias__main]


---


- [:arrow_up: Top of Document][heading__top]

- [:building_construction: Requirements][heading__requirements]

- [:zap: Quick Start][heading__quick_start]

- [&#x1F9F0; Usage][heading__usage]

- [:symbols: Available Aliases][heading__available_aliases]

  - [`init`][heading__init]

- [&#x1F5D2; Notes][heading__notes]

- [:chart_with_upwards_trend: Contributing][heading__contributing]

  - [:trident: Forking][heading__forking]
  - [:currency_exchange: Sponsor][heading__sponsor]

- [:card_index: Attribution][heading__attribution]

- [:balance_scale: Licensing][heading__license]


---



## Requirements
[heading__requirements]:
  #requirements
  "&#x1F3D7; Prerequisites and/or dependencies that this project needs to function properly"


This repository makes use of Git Submodules to track dependencies, to avoid incomplete downloads clone with the `--recurse-submodules` option...


```Bash
git clone --recurse-submodules git@github.com:git-utilities/link-alias.git
```


To update tracked Git Submodules issue the following commands...


```Bash
git pull

git submodule update --init --merge --recursive
```


To force upgrade of Git Submodules...


```Bash
git submodule update --init --merge --recursive --remote
```


> Note, forcing and update of Git Submodule tracked dependencies may cause instabilities and/or merge conflicts; if however everything operates as expected after an update please consider submitting a Pull Request.


______


## Quick Start
[heading__quick_start]:
  #quick-start
  "&#9889; Perhaps as easy as one, 2.0,..."


**Clone**


```Bash
mkdir -p ~/git/hub/git-utilities

cd ~/git/hub/git-utilities

git clone --recurse-submodules git@github.com:git-utilities/link-alias.git
```


**Install**


```Bash
cd ~/git/hub/git-utilities/link-alias

make install
```


**Upgrade**


```Bash
cd ~/git/hub/git-utilities/link-alias

make upgrade
```


**Uninstall**


```Bash
cd ~/git/hub/git-utilities/link-alias

make uninstall
```


> Note, uninstalling will remove symbolic links for `git-link-alias` script but will **not** modify any Git alias configurations.


______


## Usage
[heading__usage]:
  #usage
  "&#x1F9F0; How to utilize this repository"


After installing `git-link-alias` the any script within the `alias-scripts/` directory may be installed by name, eg...


```Bash
git link-alias init
```


______


## Available Aliases
[heading__available_aliases]:
  #available-aliases
  "&#x1F523; Scripts that may be linked via `git-link-alias` script"


> Scripts that may be linked via `git-link-alias` script


---


### `init`
[heading__init]:
  #init
  "Wrapper for git init command, merges .gitignore with .git/info/exclude"


> Wrapper for git init command, merges .gitignore with .git/info/exclude


**Example**


**`<default_template>/info/exclude`**


```
node_modules
```


> Note, `git config init.templateDir` will print the path to _`<default_template>`_, and may be used to modify the default template for initializing Git repositories, eg...
>
>
>     cp -r /usr/share/git-core/templates ~/.git/templates/default
>
>     git config init.templateDir "${HOME}/.git/templates/default"


By default the `info/exclude` file of templates and initialized repositories is not tracked by Git, this script will attempt to merge unique patterns with public `.gitignore` file for an initialized repository



```Bash
git init repository-name
```


Check the modified `.gitignore` file with preferred text viewer...


```Bash
cat repository-name/.gitignore
#> node_modules
```


> Note, if `--bare` command-line option is detected then no `.gitignore` file is merged/written


______


## Notes
[heading__notes]:
  #notes
  "&#x1F5D2; Additional things to keep in mind when developing"


This repository is not complete, Pull Requests that add features or fix bugs are certainly welcomed!


Depending upon host configurations tab-completion may not function as desired with aliased commands, the [GitHub Gist -- The Ultimate Git Alias Setup](https://gist.github.com/mwhite/6887990) may be useful for those utilizing Bash shell.


______


## Contributing
[heading__contributing]:
  #contributing
  "&#x1F4C8; Options for contributing to link-alias and git-utilities"


Options for contributing to link-alias and git-utilities


---


### Forking
[heading__forking]:
  #forking
  "&#x1F531; Tips for forking link-alias"


Start making a [Fork][aliases__fork_it] of this repository to an account that you have write permissions for.


- Add remote for fork URL. The URL syntax is _`git@github.com:<NAME>/<REPO>.git`_...


```Bash
cd ~/git/hub/git-utilities/link-alias

git remote add fork git@github.com:<NAME>/link-alias.git
```


- Commit your changes and push to your fork, eg. to fix an issue...


```Bash
cd ~/git/hub/git-utilities/link-alias


git commit -F- <<'EOF'
:bug: Fixes #42 Issue


**Edits**


- `<SCRIPT-NAME>` script, fixes some bug reported in issue
EOF


git push fork main
```


> Note, the `-u` option may be used to set `fork` as the default remote, eg. _`git push -u fork main`_ however, this will also default the `fork` remote for pulling from too! Meaning that pulling updates from `origin` must be done explicitly, eg. _`git pull origin main`_


- Then on GitHub submit a Pull Request through the Web-UI, the URL syntax is _`https://github.com/<NAME>/<REPO>/pull/new/<BRANCH>`_


> Note; to decrease the chances of your Pull Request needing modifications before being accepted, please check the [dot-github](https://github.com/git-utilities/.github) repository for detailed contributing guidelines.


---


### Sponsor
  [heading__sponsor]:
  #sponsor
  "&#x1F4B1; Methods for financially supporting git-utilities that maintains link-alias"


Thanks for even considering it!


Via Liberapay you may <sub>[![sponsor__shields_io__liberapay]][sponsor__link__liberapay]</sub> on a repeating basis.


Regardless of if you're able to financially support projects such as link-alias that git-utilities maintains, please consider sharing projects that are useful with others, because one of the goals of maintaining Open Source repositories is to provide value to the community.


______


## Attribution
[heading__attribution]:
  #attribution
  "&#x1F4C7; Resources that where helpful in building this project so far."


- [GitHub -- `github-utilities/make-readme`](https://github.com/github-utilities/make-readme)

- `git help config`

- `git help alias`


______


## License
[heading__license]:
  #license
  "&#x2696; Legal side of Open Source"


```
Collection of scripts for Git aliasing
Copyright (C) 2021 S0AndS0

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published
by the Free Software Foundation, version 3 of the License.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
```


For further details review full length version of [AGPL-3.0][branch__current__license] License.



[branch__current__license]:
  /LICENSE
  "&#x2696; Full length version of AGPL-3.0 License"


[badge__commits__link_alias__main]:
  https://img.shields.io/github/last-commit/git-utilities/link-alias/main.svg

[commits__link_alias__main]:
  https://github.com/git-utilities/link-alias/commits/main
  "&#x1F4DD; History of changes on this branch"


[aliases__community]:
  https://github.com/git-utilities/link-alias/community
  "&#x1F331; Dedicated to functioning code"


[issues__link_alias]:
  https://github.com/git-utilities/link-alias/issues
  "&#x2622; Search for and _bump_ existing issues or open new issues for project maintainer to address."

[aliases__fork_it]:
  https://github.com/git-utilities/link-alias/
  "&#x1F531; Fork it!"

[pull_requests__link_alias]:
  https://github.com/git-utilities/link-alias/pulls
  "&#x1F3D7; Pull Request friendly, though please check the Community guidelines"

[aliases__main__source_code]:
  https://github.com/git-utilities/link-alias/
  "&#x2328; Project source!"

[badge__issues__link_alias]:
  https://img.shields.io/github/issues/git-utilities/link-alias.svg

[badge__pull_requests__link_alias]:
  https://img.shields.io/github/issues-pr/git-utilities/link-alias.svg

[badge__main__link_alias__source_code]:
  https://img.shields.io/github/repo-size/git-utilities/link-alias


[sponsor__shields_io__liberapay]:
  https://img.shields.io/static/v1?logo=liberapay&label=sponsor&message=git-utilities

[sponsor__link__liberapay]:
  https://liberapay.com/git-utilities
  "&#x1F4B1; Sponsor developments and projects that git-utilities maintains via Liberapay"

