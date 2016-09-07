#!/bin/bash


STARTL='\n\033[1m#############################################################################################################################\n'
ENDL='#############################################################################################################################\n\n\033[0m'

printf $STARTL
echo 'Cleaning up stig playbooks....'
printf $ENDL

rm $HOME/helion/hos/ansible/stig*
rm -r $HOME/helion/hos/ansible/roles/stig*
rm -r $HOME/helion/hos/services/stig*
(cd my_cloud/definition/data/ && ls -1 *_vars.yml) | while read a b; do rm $HOME/helion/my_cloud/definition/data/$a; done

printf $STARTL
echo 'DONE: Cleaning up stig playbooks....'
printf $ENDL

printf $STARTL
echo 'Copy the playbooks and conf in place...'
printf $ENDL

cp hos/ansible/stig-* $HOME/helion/hos/ansible/
cp -r hos/ansible/roles/* $HOME/helion/hos/ansible/roles/
cp -r hos/services/stig $HOME/helion/hos/services/


cp my_cloud/definition/data/*_vars.yml      $HOME/helion/my_cloud/definition/data/


printf $STARTL
echo 'DONE: Copy the playbooks and conf in place...'
printf $ENDL

printf $STARTL
echo 'Committing changes to input model...'
printf $ENDL

(cd $HOME/helion/hos/ansible/ && git add -A && git commit -a --amend --no-edit)

printf $STARTL
echo 'DONE: Committing changes to input model...'
printf $ENDL

printf $STARTL
echo 'Run config processor and ready deployement'
printf $ENDL

(cd $HOME/helion/hos/ansible/ &&\
 ansible-playbook -i hosts/localhost config-processor-run.yml -e encrypt="" -e rekey="" &&\
 ansible-playbook -i hosts/localhost ready-deployment.yml)

printf $STARTL
echo 'DONE: Config processor and ready deployement'
printf $ENDL

printf $STARTL
echo '#######################     Starting the STIG deploy     ####################################################################'
printf $ENDL

(cd $HOME/scratch/ansible/next/hos/ansible/ && time ansible-playbook -i hosts/verb_hosts stig-deploy.yml)

printf $STARTL
echo '#######################       Done the STIG deploy       ####################################################################'
printf $ENDL

