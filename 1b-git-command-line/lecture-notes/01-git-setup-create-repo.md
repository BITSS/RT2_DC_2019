---
layout: page
root: ..
title: A Better Kind of Backup
---

## Local Repo

Git will keep track of the _changes_ to your files, rather than keep multiple copies of the files.
It saves the first version, then keeps track of subsequent changes to that version.
This makes it efficient and speedy.
It can recreate any version (go back in time) by adding up all the changes
to get to where you want to be.

## Setting Up

The first time we use Git on a new machine,
we need to configure a few things.
Here's how Dracula sets up his new laptop:

~~~ {.bash}
$ git config --global user.name "Vlad Dracula"
$ git config --global user.email "vlad@tran.sylvan.ia"
$ git config --global color.ui "auto"
$ git config --global core.editor "nano"
~~~

(Please use your own name and email address instead of Dracula's,
and please make sure you choose an editor that's actually on your system,
such as `notepad` on Windows.)

Git commands are written `git verb`,
where `verb` is what we actually want it to do.
In this case,
we're telling Git:

*   our name and email address,
*   to colorize output,
*   what our favorite text editor is, and
*   that we want to use these settings globally (i.e., for every project),

The four commands above only need to be run once:
the flag `--global` tells Git to use the settings for every project on this machine.

> #### Proxy
>
> In some networks you need to use a proxy. If this is the case you may also
> need to tell Git about the proxy:
>
> ~~~ {.bash}
> $ git config --global http.proxy proxy-url
> $ git config --global https.proxy proxy-url
> ~~~
>
> To disable the proxy, use
>
> ~~~ {.bash}
> $ git config --global --unset http.proxy
> $ git config --global --unset https.proxy
> ~~~

~~~
$ git config -h
$ git config --help
~~~

## Creating a Repository

* Once Git is configured,
we can start using it.
* Let's create a directory for our work:

~~~ {.bash}
$ mkdir planets
$ cd planets
~~~

and tell Git to make it a [repository](../../gloss.html#repository)&mdash;a place where
Git can store old versions of our files:

~~~ {.bash}
$ git init
~~~

If we use `ls` to show the directory's contents,
it appears that nothing has changed:

~~~ {.bash}
$ ls
~~~

But if we add the `-a` flag to show everything,
we can see that Git has created a hidden directory called `.git`:

~~~ {.bash}
$ ls -a
~~~

~~~ {.output}
.	..	.git
~~~

> ## Look around inside the `.git` folder
>~~~
> cd .git
>~~~

Explore `.git`

* Git stores information about the project in this special sub-directory.
* If we ever delete it, we will lose the project's history.

* We can check that everything is set up correctly
* by asking Git to tell us the status of our project:

~~~ {.bash}
$ git status
~~~

~~~ {.output}
# On branch master
#
# Initial commit
#
nothing to commit (create/copy files and use "git add" to track)
~~~

_On the white board draw a box representing the working area and
 explain that this is where you work and make changes._


## Episodes
 
 * [Introduction to Git](00-git-intro.md)
 * [Creating a Repository and Tracking Files](01-git-setup-create-repo.md)
 * [Exploring History and Reverting](03-exploring-hist.md)
 * [Ignoring Files](04-ignoring-things.md)
 * [Collaborating with GitHub](05-github-collab.md)
