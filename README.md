# Raneto Docker image

A container to expose your Markdown-based project documentation with Raneto.

While a Raneto base image is available at the time of writing (https://github.com/chanux/docker-raneto) I felt like creating my own so that:

* It was based on official Node images (node, npm and other tools already there). I used slim to keep things lightweight.
* The container was exposing a local docs folder via Raneto, so that I can use the same image on different projects with docker-compose.
* I was finally able to grok this srtange beast that is Docker :)

## Content

The last version of this image is based on Node 6.1.0-slim image, with global gulp-cli and a modified version of [Raneto 0.9.0](https://github.com/sparkfabrik/Sparketo).

## Usage

This image works mounting a local documentation folder in a volume inside the container, and exposing Raneto on port 3000 (standard).
It also supports a custom configuration file for Raneto.

To run the image mounting only documentation's folder issue:

`docker run -p 80:80 -v </path/to/your/content>:/srv/raneto/content -d sparkfabrik/docker-node-raneto`

To run the image with documentation's folder and a custom config file issue:

`docker run -p 80:80 -v </path/to/your/content-folder>:/srv/raneto/content -v </path/to/your/config-file>:/srv/raneto/config.js  -d sparkfabrik/docker-node-raneto`

You can then browse your content visiting:

    http://localhost:80

## Contributions and todo

* PRs are welcome, I'll try to review them as quickly as possible.
* I'm not fond at all of the way configuration is included. It would be top to have a default config and a local one in content directory. I'm not that skilled in node.js to know hot to achieve this ATM. If anyone has a good idea, PR it to me.
* Currently only standard theme is available in the image. Being able to dinamically read new themes from local volume would be great. Same as above.

## Credits

Thanks to chanux who inspired me a bit with his [Chanux Raneto Docker image](https://github.com/chanux/docker-raneto).
Thanks to my colleague Paolo Mainardi who forced me to consider Docker as an actual tool, explained me lot of black magic and gave me great advices on sucha small Dockerfile.
Raneto team for providing a simple and effective tool for this widespread need. Exactly what I was looking for! :)
