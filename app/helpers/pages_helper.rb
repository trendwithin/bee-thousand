module PagesHelper
  def active? path
    "active" if current_page? path
  end

  def nav_items
    [
      {
        url: pages_contact_path,
        title: 'Contact'
      },
      {
        url: pages_about_path,
        title: 'About'
      },
      {
        url: pages_testimonial_path,
        title: 'Testimonials'
      }
    ]
end

  def links_helper tag_type, style
    nav_links = ''
    nav_items.each do |item|
      nav_links << "<a href='#{item[:url]}' class='#{style} #{active? item[:url]}'>#{item[:title]}</a>"
    end
    nav_links.html_safe
  end
end
