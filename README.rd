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

  @groonga_product = "rroonga" # Use downcase product name
  include_theme("groonga")

You will find Rroonga logo is used in your slide.

If you want to use other product such as Mroonga, use "mroonga"
instead of "rroonga".

=== Run as slide show mode

You can show your slide for exhibit by using slide show mode. On slide
show mode, your slide is moved to the next page automatically. When
your slide goes to the last page, your slide goes to the first page.

Set "RABBIT_SLIDE_SHOW" environment variable to use slide show mode
like the following:

  % RABBIT_SLIDE_SHOW=yes rake

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
