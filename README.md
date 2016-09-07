# STIG compliance for Debian

Clone this repository to the home directory of the user who is installing HOS and run the "run.sh" script

The HOS input model is needed for this to run

Variables are located in ./hos/ansible/roles/stig-comlpliant/vars/main.yml

A valid logserver needs to be set for rsyslog config

A GRUB password for the user root will also need to be set, please note this does NOT have to be the root password.

###The following files are templated so any customisations will need to be added to the template file
####file                                template
/etc/pam.d/common-password              comm-pwd.j2

/etc/bash.bashrc                        bashrc.j2

/etc/issue                              SRG-OS-000006-GPOS-00006.j2

/etc/issue.net                          SRG-OS-000006-GPOS-00006.j2

/etc/screenrc                           screenrc.j2


#### To disable any of the STIG points comment out the line in stig/hos/ansible/stig-deploy.yml


