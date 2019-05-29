echo "Searching for composer.json ..."

count=0

jq -c '.repositories[].url' ../../composer.json |
while read i;
do
	if [ $count -ne 0 ]; then

    	formmatedSSHurl=$(echo "$i" | sed 's/"//g' | cut -c 9- | sed 's#/#:#')

	    git clone git@$formmatedSSHurl

		gitOriginfolderName=$(echo "$formmatedSSHurl" | cut -d "/" -f 2 | cut -d. -f1)
		gitDestinationfolderName=$(echo "$gitOriginfolderName" | cut -d "-" -f2- )

		# mkdir $gitDestinationfolderName

    		cp $gitOriginfolderName/.git $gitDestinationfolderName -R

		rm -Rf $gitOriginfolderName

		echo "\n"
	fi
    count=$(( $count + 1 ))
done
