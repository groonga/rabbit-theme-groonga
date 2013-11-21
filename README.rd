= Groogna theme

The Rabbit theme for Groonga family.

== For author

=== Show

  rake

=== Publish

  rake publish

== For users

=== Install

  gem install rabbit-theme-groonga

=== Show

  rabbit -t rabbit-theme-groonga rabbit-theme-benchmark-en.gem

== Customize

=== Change product

You can choose one of products in Groonga family. Here are available
products:

  * Groonga
  * Rroonga
  * Mroonga
  * Droonga

The default is Groonga.

If you want to change product to Rroonga from Groonga, change your
slide source to use your custom theme.

Before:

  = Title

  : theme
     groonga

After:

  = Title

  : theme
     .

Then put "theme.rb" to the directory that locates your slide source
with the following content:

  @groonga_family = "rroonga" # Use downcase product name
  include_theme("groonga")

You will find Rroonga logo is used in your slide.

If you want to use other product such as Mroonga, use "mroonga"
instead of "rroonga".

== License

This theme and related files are licensed under ((<CC BY
3.0|URL:http://creativecommons.org/licenses/by/3.0/>)).

Use one of the following as the author:

  * Groonga Project
  * Groongaプロジェクト

Provided patches, codes and so on are also licensed under the same
licenses. Groonga Project can change the license of them. Groonga
Project considers that contributors agree with the rule when they
contribute their patches, codes and so on.
