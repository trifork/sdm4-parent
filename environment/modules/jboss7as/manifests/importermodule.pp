define jboss7as::importermodule( $importername = '') {
	include "jboss7as::importerdirectories"

	if $importername == '' {
        $modulename = $title
      } else {
        $modulename = $importername
      }

	$module_main_dir="/pack/jboss/modules/sdm4/config/${modulename}/main"

	File {
		ensure => present,
    	owner => "jboss",
		group => "jboss",
	}

	# NSP-Util Slalog configuration
	file {"${module_main_dir}/nspslalog-${modulename}.properties":
		content => template("jboss7as/nspslalog-importer.properties"),
	}

	file {"${module_main_dir}/log4j-nspslalog.properties":
		content => template("jboss7as/log4j-nspslalog-importer.properties"),
	}

	# support for Spring use of com.sun.rowset.CachedRowsetImpl, only needed because the tests run on OpenJDK which does not include this class
    file {"${module_main_dir}/rowset.jar":
        ensure => present,
        source => "puppet:///modules/jboss7as/rowset.jar",
        require => File["${module_main_dir}"]
    }

	# JBoss module
   	file {["${module_main_dir}/..", "${module_main_dir}"]:
        ensure => directory,
        require => File["/pack/jboss"],
    }

	file {"${module_main_dir}/log4j.properties":
		content => template("jboss7as/log4j-importer.properties"),
		require => File["${module_main_dir}"],
	}

	file {"${module_main_dir}/module.xml":
		content => template("jboss7as/sdm-importer-module.xml"),
		require => File["${module_main_dir}"],
	}
}