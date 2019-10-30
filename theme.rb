# -*- coding: utf-8 -*-
#
# Copyright (C) 2013-2015  Groonga Project
#
# License: CC BY 3.0

@groonga_font_family ||= nil
@font_family =
  @groonga_font_family ||
  find_font_family("モトヤLマルベリ3等幅") ||
  @font_family

@groonga_product ||= "groonga"

colors = {
  "groonga" => {
    :foreground => "#38a3ef",
    :emphasis   => "#0071bc"
  },
  "rroonga" => {
    :foreground => "#ae0000",
    :emphasis   => "#740000",
  },
  "mroonga" => {
    :foreground => "#f8bb5e",
    :emphasis   => "#ff931e",
  },
  "droonga" => {
    :foreground => "#ae5881",
    :emphasis   => "#90196e",
  },
  "pgroonga" => {
    :foreground => "#5795c6",
    :emphasis   => "#1e3d57",
  },
}

mysql_color = "#015a84"
postgresql_color = "#0095bc"
background_color = "#ffffff"

headline_bar_color = "#333333"

base_color = colors[@groonga_product]

set_graffiti_color("#{base_color[:foreground]}99")
set_graffiti_line_width(10)

set_progress_foreground(base_color[:foreground])
set_progress_background(background_color)

@title_slide_title_font_size ||= @x_large_font_size * 1.3
@title_slide_content_source_font_size ||= @x_small_font_size
@title_slide_date_font_size ||= @x_small_font_size

@default_headline_line_expand = true
@default_headline_line_color = headline_bar_color
@default_headline_line_width = canvas.height * 0.01

@default_emphasis_color = base_color[:emphasis]

@block_quote_image_background_alpha = 0.3

@description_term_line_color = base_color[:foreground]
@default_description_item1_mark_color = base_color[:foreground]
@default_block_quote_item1_mark_color = base_color[:foreground]

@slide_number_uninstall = !print?

@tag_handlers ||= {}
@tag_handlers["groonga"] = lambda do |options|
  options[:target].prop_set("foreground", colors["groonga"][:emphasis])
end
@tag_handlers["rroonga"] = lambda do |options|
  options[:target].prop_set("foreground", colors["rroonga"][:emphasis])
end
@tag_handlers["mroonga"] = lambda do |options|
  options[:target].prop_set("foreground", colors["mroonga"][:emphasis])
end
@tag_handlers["droonga"] = lambda do |options|
  options[:target].prop_set("foreground", colors["droonga"][:emphasis])
end
@tag_handlers["pgroonga"] = lambda do |options|
  options[:target].prop_set("foreground", colors["pgroonga"][:emphasis])
end
@tag_handlers["mysql"] = lambda do |options|
  options[:target].prop_set("foreground", mysql_color)
end
@tag_handlers["postgresql"] = lambda do |options|
  options[:target].prop_set("foreground", postgresql_color)
end

include_theme("default")

@groonga_icon_images ||= ["#{@groonga_product}-icon.svg"]
@icon_images = @groonga_icon_images
include_theme("icon")

@groonga_slide_logo_image ||= lambda do |slide|
  product = slide["groonga-product"] || @groonga_product
  "#{product}-icon-full-size.svg"
end
@slide_logo_image = @groonga_slide_logo_image
@slide_logo_position = Proc.new do |slide, canvas, loader|
  x = slide.margin_left
  if slide.is_a?(TitleSlide)
    y = canvas.height - loader.height - slide.margin_bottom
  else
    y = slide.margin_top
  end
  [x, y]
end
@slide_logo_height = Proc.new do |slide, canvas|
  slide[0].first_line_height
end
include_theme("slide-logo")

slide_show_mode_p = !ENV["RABBIT_SLIDE_SHOW"].nil?

unless print?
  @image_slide_number_image ||= "mini-usa-taro.png"
  @image_slide_number_show_text = true
  include_theme("image-slide-number")
  if canvas.allotted_time
    @image_timer_image ||= "mini-kame-taro.png"
    include_theme("image-timer") unless slide_show_mode_p
  end
end

@slide_footer_info_left_text ||= canvas.title.gsub(/\n+/, ' ')
@slide_footer_info_right_text ||= "Powered by Rabbit #{Rabbit::VERSION}"
include_theme("slide-footer-info")

match(TitleSlide, Author) do |authors|
  authors.horizontal_centering = false
  authors.align = :left

  authors.margin_top = @space * 2

  authors.add_post_draw_proc do |author, canvas, x, y, w, h, simulation|
    cancel_height = author.height + author.margin_bottom
    [x, y - cancel_height, w, h + cancel_height]
  end
end

match(TitleSlide, Institution) do |institutions|
  institutions.horizontal_centering = false
  institutions.align = :right
end

match(TitleSlide, Date) do |dates|
  dates.horizontal_centering = false
  dates.align = :right
end

match(TitleSlide, ContentSource) do |sources|
  sources.horizontal_centering = false
  sources.align = :right

  sources.margin_top = @space
  sources.margin_bottom = 0
end

match(Slide, HeadLine) do |heads|
  heads.horizontal_centering = true
end

match(Slide, Body) do |bodies|
  bodies.vertical_centering = true
  bodies.each do |body|
    next if body.elements.all? {|element| element.is_a?(Image)}
    next if body.elements.any? {|element| element.is_a?(BlockQuote)}
    next if body.elements.any? {|element| element.is_a?(PreformattedBlock)}
    next if body.elements.any? {|element| element.is_a?(Table)}

    if body.elements.collect {|element| element.class} == [Paragraph]
      body.elements.each do |element|
        have_align_tag = false
        have_align_tag = true if element.have_tag?("left")
        have_align_tag = true if element.have_tag?("right")
        element.horizontal_centering = true unless have_align_tag
        if element.have_tag?("as-large-as-possible")
          element.as_large_as_possible("one-paragraph")
        elsif element.text.size < 50 or element.elements.any? {|e| e.is_a?(Note)}
          element.prop_set("size", @x_large_font_size)
        else
          element.prop_set("size", @large_font_size)
        end
      end
    end
  end
end

match("**", Emphasis) do |texts|
  texts.each do |text|
    product = text.slide["groonga-product"] || @groonga_product
    emphasis_color = colors[product][:emphasis]
    prop_set("foreground", emphasis_color)
  end
end

@lightning_talk_proc_name = "lightning-groonga"
@lightning_talk_as_large_as_possible = true
include_theme("lightning-talk-toolkit")

match(Slide) do |slides|
  slides.each do |slide|
    slide.takahashi
    slide.headline.wrap_mode = false
    slide.headline.prop_set("size", @normal_font_size)
  end
end

include_theme("title-on-image-toolkit")

if slide_show_mode_p
  @slide_show_span = 5000
  @slide_show_loop = true
  include_theme("slide-show")
end
