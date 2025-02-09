# chikuwansible - my unique ubuntu environment maker

* This can make my unique ubuntu environment.
* Your using one task-file of this repository enable installing any program.

## Prepare Ansible

### Step1. Install Ansible

If you are ubuntu, try this command:

```
./install_ansible.sh
```

If not, you have to read [this](http://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-the-control-machine).

### Step2. Make /usr/bin/python

If you have no /usr/bin/python, you have to execute this command:
```
sudo ln -s /usr/bin/python{version} /usr/bin/python
```

{version} is python version you have.

(example)
```
sudo ln -s /usr/bin/python3.5 /usr/bin/python
```

### Step3. Check

```
$ cd chikuwansible.git
$ ansible-playbook test.yml

PLAY [localhost] *************************************************************************************

TASK [Ping to localhost] *****************************************************************************
ok: [localhost]

PLAY RECAP *******************************************************************************************
localhost                  : ok=1    changed=0    unreachable=0    failed=0
```

## Usage

### Step1. Edit "vars/editable.yml"

* "vars/editable.yml" is a file defining variables.
* You may have to edit this accordingly.

```
cd chikuwansible.git
vim vars/editable.yml
```

### Step2. Make A Playbook

* Make My Unique Environment
    * You have "make_my_environment.yml"

* Make Your Unique Environment
    * You have "tasks/\*.yml"

```
cd chikuwansible.git
cp -a make_my_environment.yml make_your_environment.yml
vim make_your_environment.yml
```

**(tasks)**

* apt_update_upgrade.yml
    * apt-update, apt-upgrade
* apt.yml
    * apt-install my-favorite-packages
* make_bashrc.yml
    * make my unique bashrc
* install_pip.yml
    * install pip
* install_pyenv.yml
    * install pyenv
* install_pyenv_versions.yml
    * install python2 and python3 for pyenv
* install_pipenv.yml
    * install pipenv
* install_latest_golang.yml
    * install latest golang
* install_rust.yml
    * install rust
* install_neovim.yml
    * install neovim and make my unique init.vim
* install_rusgit.yml
    * install https://github.com/miyagaw61/rusgit
* install_exa.yml
    * install https://github.com/ogham/exa
* make_directories.yml
    * make my unique directories
* remake_bash_files.yml
    * remake bash files
* remake_neovim_files.yml
    * remake neovim files
* copy_sudoers.yml
    * copy my unique sudoers
* install_ffmpeg.yml
    * install ffmpeg

### Step3. Prepare password-file

```
$ vim /path/to/.sudo_password.txt
$ vim /path/to/.vault_password.txt
```

file name is any name.
vault password is any password for ansible-vault.

### Step4. initialize ansible-vault

```
$ ./chikuwansible-vault init /path/to/.sudo_password.txt /path/to/.vault_password.txt
```

### Step5. Run Ansible-Playbook

```
$ ./make_my_env
```

OR

```
$ ./chikuwansible-playbook make_your_env.yml
```
