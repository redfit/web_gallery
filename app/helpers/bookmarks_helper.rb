module BookmarksHelper
  def each_row(idx, max, &block)
    html = ""
    html.concat "<div class='row'>" if idx % 3 == 0
    html.concat capture(&block)
    html.concat "</div>" if idx % 3 == 2 || idx == (max - 1)
    html.html_safe
  end
end
