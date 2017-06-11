FROM jekyll/jekyll:3.4.0

# Copy files to jekyll
COPY . /srv/jekyll

# Build the app with Jekyll
WORKDIR /srv/jekyll
