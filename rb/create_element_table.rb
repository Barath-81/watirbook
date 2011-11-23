def html_class
  html(%{ class="click-me"})
end
def html_double
  %{#{html}<br>#{html}}
end
def html_id
  html(%{ id="click-me"})
end
def html_name
  html(%{ name="click-me"})
end
def html_title
  html(%{ title="click-me"})
end
def regexp(how)
  %{browser.a(#{how} => /click/).click}
end
def string(how)
  %{browser.a(#{how} => "click-me").click}
end

def create_html(body)
  header = "<html><head><title>a element</title></head><body><h1>a element</h1><table border=\"1\"><tbody><tr><th>how</th><th>html</th><th>regexp</th><th>string</th><th>other</th>"
  footer = "</tbody></table></body></html>"
  table = header + body + footer
  File.open("../reference/a.htm", "w") {|file| file.write(table)}
end
def body
  table = ""
  element.each do |how, data|
    if data

      html = ""
      regexp = ""
      string = ""
      other = ""
      data.each do |key, value|
        if key == :html
          require "cgi"
          html = CGI::escapeHTML(value).gsub("&lt;br&gt;", "<br>")
        elsif key == :regexp
          regexp = value
        elsif key == :string
          string = value
        else
          other << "#{key}: #{value}<br>"
        end
      end

      table << "<tr><td>#{how}</td><td>#{html}</td><td>#{regexp}</td><td>#{string}</td><td>#{other}</td></tr>"
    else
      table << "<tr><td>#{how}</td><td colspan='4'>not supported</td></tr>"
    end
  end
  table
end