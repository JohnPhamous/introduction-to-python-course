folderName=$1
regex='[a-z]{3,5}[0-9]{3}'
pathRegex='\/\w*\/\w*\/\w*'

for notebook in $folderName/*.ipynb;
do
	#echo $notebook
	user=$(grep -Eo $regex <<< $notebook)
	#echo $user
	#userPath=$(getent passwd $user)
	userPath=$(grep -o $pathRegex <<< $(getent passwd $user))
	#echo $userPath
	mv $notebook ${userPath}/assignments
	chmod go+rx ${userPath}/assignments/*
done
