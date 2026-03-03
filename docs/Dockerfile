FROM jekyll/jekyll:4

WORKDIR /srv/jekyll

COPY . .

EXPOSE 4000

CMD ["jekyll", "serve", "--host", "0.0.0.0", "--port", "4000", "--watch", "--livereload"]

