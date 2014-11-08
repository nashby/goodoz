bookParamsTable       = document.querySelector    '#all-params tbody'
bookParamsTableParams = document.querySelectorAll '#all-params td'
ISBNRegexp            = /(\s)*[0-9]+[- ][0-9]+[- ][0-9]+[- ][0-9]*[- ]*[xX0-9]/

isbn = null

for param in bookParamsTableParams
  param = param.innerHTML
  isbn  = param.replace(/-/g, '') if ISBNRegexp.test(param)

if isbn
  xhr = new XMLHttpRequest()
  xhr.open("GET", "https://www.goodreads.com/book/review_counts.json?isbns=#{isbn}&key=iCKldysmu9HEvXtDrUYw", true);
  xhr.onreadystatechange = ->
    if xhr.readyState == 4
      books = JSON.parse(xhr.responseText).books

      if books
        book = books[0]

        id     = book.id
        votes  = book.work_ratings_count
        rating = book.average_rating

        tr = document.createElement("tr")

        th = document.createElement("th")
        th.appendChild(document.createTextNode("Goodreads рейтинг: "))

        td = document.createElement("td")

        a  = document.createElement("a")
        a.href = "https://www.goodreads.com/book/show/#{id}"
        a.appendChild(document.createTextNode("#{rating} (всего #{votes} голосов)"))

        td.appendChild(a)

        tr.appendChild(th)
        tr.appendChild(td)

        bookParamsTable.insertBefore(tr, bookParamsTable.querySelector('.goods_social_btn'))

  xhr.send()
