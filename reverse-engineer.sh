#!/bin/bash

re_name="$1";

if [ "$re_name" != "" ] && [ -d $re_name ]
then
	echo "";
	echo "reverse engineering project: $re_name";

	root_path=`pwd`;
	input_file="$root_path/web-project-init.sh";
	output_file="$root_path/web-project-init-re.sh";
	default_tab="__";

	write_file(){
		original_file_name=$1;
		file_tab_space=$2;
		file_name=`echo $1 | sed 's/'$re_name'/$project/'`;

		if [ $file_name != 'package.json' ] && [ $file_name != '.DS_Store' ]
		then
			# echo " |$file_tab_space writing file: $file_name";

			echo -n "cat <" >> $output_file;
			echo -n "<EOT >" >> $output_file;
			echo "> $file_name;" >> $output_file;
			# cat $original_file_name | sed 's/'$re_name'/$project/' >> $output_file;
			echo "EOT" >> $output_file;
		fi
	}

	recurse_dir(){
		dir_name=$1
		is_root=$2
		tab_space=$3

		if [ $dir_name != 'node_modules' ] && [ $dir_name != 'dist' ]
		then
			# echo "$tab_space recursing director: $dir_name";

			if [ $is_root != 'root' ]
			then
				echo "mkdir $dir_name;" >> $output_file;
				echo "cd $dir_name;" >> $output_file;
			fi

			cd $dir_name;

			for i in `ls -A`; do
				if [ -d $i ]
				then
					recurse_dir $i notroot "$default_tab$tab_space";
					tab_space=`echo "$tab_space" | sed 's/^'$default_tab'//'`;
					# echo "";
				else
					write_file $i "$default_tab$tab_space";
				fi
			done

			if [ $is_root != 'root' ]
			then
				echo "cd ..;" >> $output_file;
			fi

			# echo "";
			cd ..;
		fi
	}

	echo '' > $output_file;

	# prime shell
	sed -n '1,/file creation : start/ p' $input_file >> $output_file;

	# find package.json differences
	echo "";
	echo "package differences:"
	grep -Fxvf $re_name/package.json.orig $re_name/package.json;
	echo "";

	echo "" >> $output_file;

	# start reading file structure
	recurse_dir $re_name root "";

	echo "" >> $output_file;

	# close shell
	sed -n '/file creation : end/,$ p' $input_file >> $output_file;
else
	echo "";
	echo "No project found: '$re_name'";
	echo "";
fi