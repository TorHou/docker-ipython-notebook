Docker IPython Container
========================

IPython running in a docker container. This image can be used to integrate IPython into Galaxy.
A variety of different packages are pre-installed and can be used right away.

This docker container is used by the [Galaxy-IPython project](https://github.com/bgruening/galaxy-ipython) and can be installed from the [docker.io index](https://registry.hub.docker.com/u/bgruening/docker-ipython-notebook/).

Usage
=====

* Build your own image and run it

 [Docker](https://www.docker.com) is a pre-requirement for this project. You can build the container with:
 ```bash
  docker build -t ipython-notebook . 
 ```
 The build process can take some time, but if finished you can run your container with:
 ```bash
  docker run -p 7777:6789 -v /home/user/foo/:/import/ -t ipython-notebook
 ```
 and you will have a running [IPython Notebook](http://ipython.org/notebook.html) instance on ``http://localhost:7777/ipython/``.

* Run a pre-build image from docker registry

 ``docker run -p 7777:6789 -v /home/user/foo/:/import/ bgruening/docker-ipython-notebook ``  



Authors
=======

 * Bjoern Gruening
 * Eric Rasche

History
=======

- v0.1: Initial public release


Licence (MIT)
=============

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
