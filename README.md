edb is a cross platform x86/x86-64 debugger. It was inspired by [Ollydbg](http://www.ollydbg.de/ "Ollydbg"), but aims to function on x86 and x86-64 as well as multiple OS's. Linux is the only officially supported platform at the moment, but FreeBSD, OpenBSD, OSX and Windows ports are underway with varying degrees of functionality.

![Screenshot](http://codef00.com/img/debugger.png)

edb is available under the GPL 2 license, see the COPYING for details.

NOTE: This README now only covers the most essential documentation, for more
complete documentation see the [wiki](https://github.com/eteran/edb-debugger/wiki)


Cloning
-------

When cloning the repo, please use git's `--recursive` flag to ensure that the sub-modules will be properly cloned and updated to the correct versions. Here is an example:

`git clone --recursive git@github.com:eteran/edb-debugger.git`

Compiling
---------

Compiling edb is generally quite simple. edb currently depends on the 
following packages:

* Qt >= 4.6
* Boost >= 1.35 (headers only)

Many distributions already have packages that satisify these.

Once you have Qt and Boost installed, it is as simple as

	$ qmake
	$ make

This will build the debugger along with all plugins I have written. On certain 
systems your qmake may be named slightly differently, I've noticed that the 
Fedora Core rpms name it `qmake-qt4`.

If you are planning on doing a make install, you likely want to specify the 
default plugin path, here's how you would do that.

	$ qmake -makefile DEFAULT_PLUGIN_PATH="/usr/lib/edb/"
	$ make


Installing
----------

Basic installation is simple, you may run

	$ make install

Or if you would like to specify where things should go, you probably want to 
use something like this

	make INSTALL_ROOT=/usr/ install

In which case the plugins will be installed in /usr/lib/edb and the binaries 
will be installed in /usr/bin/. Finally, if you are doing a make install, you 
probably want to specify a default plugin path, this is done during the qmake 
process.

Generating Symbols
------------------

In order to have edb take advantage of certain features (such as the Heap 
analyzer plugin), it will need some symbol maps to work with. The easiest way 
to create these is to run edb with the --symbols flag, here's an example:

$ ./edb --symbols /lib/libc.so.6 > symbols/libc.so.6.map

The name of the symbol file IS IMPORTANT, a quick and dirty way to get all 
symbols from most existing libraries on your system would be like this:

$ for i in $(ls /lib/*.so* /lib/i386-linux-gnu/*.so* /lib/x86_64-linux-gnu/*.so* /lib32/*.so* /usr/lib/*.so*); do edb --symbols $i > $(basename $i).map; done

This will take a moment, but not that long and you will have symbols based on 
all libraries on your system. Note that the edb_make_symbolmap script will work 
on regular binaries as well, not just libraries. So if you are debugging an 
application, you may want to generate its symbols as well. Eventually, I will 
build a "Regenerate Symbols" feature into edb (a plugin perhaps?), but for now, 
the script will have to do.
