module.exports = (grunt) ->

  _ = grunt.util._

  files =
    sourceJSON: "http://docs.webplatform.org/Special:Ask/-5B-5BCategory:CSS%20Properties-5D-5D/format=json/limit=500/offset=0/link=none/headers=hide/syntax=basic/prettyprint=yes/"
    tempJSON: "tmp/css_properties.json"
    tempCSS: "tmp/properties.css"
    initialCSS: "dist/initial.css"

  grunt.loadNpmTasks task for task in [
    "grunt-contrib-clean"
    "grunt-contrib-concat"
    "grunt-contrib-copy"
    "grunt-curl"
  ]

  grunt.initConfig

    pkg: grunt.file.readJSON("package.json")

    banner: """
            /*!
             * <%= pkg.name %> - v<%= pkg.version %> - <%= grunt.template.today("yyyy-mm-dd") %>
             * <%= pkg.homepage %>
             *
             * Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author %>
             * <%= pkg.license %> License
             */\n\n
            """

    clean:
      tmp: "tmp"
      dist: "dist"

    curl:
      cssProperties:
        src: files.sourceJSON
        dest: files.tempJSON

    copy:
      transform:
        src: files.tempJSON
        dest: files.tempCSS
        options:
          processContent: (content, srcPath) ->
            results = JSON.parse(content).results
            props = _(results).keys().map (prop) ->
              prop.replace(/^css\/properties\//, '') + ":initial;"

            """
            /*
             * Property list from WebPlatform docs:
             * #{ files.sourceJSON }
             */

            * {
              #{ props.join "\n  " }
            }

            """

    concat:
      options:
        banner: "<%= banner %>"

      dist:
        src: files.tempCSS
        dest: files.initialCSS

  grunt.registerTask "default", [ "curl", "copy", "concat", "clean:tmp" ]
