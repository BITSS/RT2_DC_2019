---
title: Ignoring Files
author: "Tim Dennis"
date: 2018-09-05
---

### Ignoring Things

What if we have files that we do not want Git to track for us,
like backup files created by our editor
or intermediate files created during data analysis.

_while git can keep track of data files, this is often not a great idea.
Share story of .rdata files in collaborative project. Why they needed to be in the .git ignore file_

Let's create a few dummy files:

~~~ {.bash}
$ mkdir results
$ touch a.dat b.dat c.dat results/a.out results/b.out
~~~

and see what Git says:

~~~ {.bash}
$ git status
~~~

~~~ {.output}
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	a.dat
#	b.dat
#	c.dat
#	results/
nothing added to commit but untracked files present (use "git add" to track)
~~~

_Note: if you already added these files (git add .) you can unstage them by typing git reset HEAD_

Putting these files under version control would be a waste of disk space.
What's worse,
having them all listed could distract us from changes that actually matter,
so let's tell Git to ignore them.

We do this by creating a file in the root directory of our project called `.gitignore`.

~~~ {.bash}
$ nano .gitignore
$ cat .gitignore
~~~

~~~ {.output}
*.dat
results/
~~~

These patterns tell Git to ignore any file whose name ends in `.dat`
and everything in the `results` directory.
(If any of these files were already being tracked,
Git would continue to track them.)

Once we have created this file,
the output of `git status` is much cleaner:

~~~ {.bash}
$ git status
~~~

~~~ {.output}
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	.gitignore
nothing added to commit but untracked files present (use "git add" to track)
~~~

The only thing Git notices now is the newly-created `.gitignore` file.
You might think we wouldn't want to track it,
but everyone we're sharing our repository with will probably want to ignore
the same things that we're ignoring.
Let's add and commit `.gitignore`:

~~~ {.bash}
$ git add .gitignore
$ git commit -m "Add the ignore file"
$ git status
~~~

~~~ {.output}
# On branch master
nothing to commit, working directory clean
~~~

As a bonus,
using `.gitignore` helps us avoid accidentally adding files to the repository that we don't want.

~~~ {.bash}
$ git add a.dat
~~~

~~~ {.output}
The following paths are ignored by one of your .gitignore files:
a.dat
Use -f if you really want to add them.
fatal: no files added
~~~

If we really want to override our ignore settings,
we can use `git add -f` to force Git to add something.
We can also always see the status of ignored files if we want:

~~~ {.bash}
$ git status --ignored
~~~

~~~ {.output}
# On branch master
# Ignored files:
#  (use "git add -f <file>..." to include in what will be committed)
#
#        a.dat
#        b.dat
#        c.dat
#        results/

nothing to commit, working directory clean
~~~

_To discard all your most recent changes and GO BACK IN TIME,
first look at your `git log` to decide what version you want to go back to.
Remember the first 5-7 digits in the commit code of the version that wasn't screwed up._

_use `git reset --hard versioncode`_

_To roll back to a specific file, use
`git checkout version name --filename`_

_To roll back one version (usually I know that I messed up pretty quickly)
`git checkout master~1 PathToFile`_


_A short exercise to show moving back and forth. If I mess up and I notice right away,
 might want to go back in time quickly. Commit some changes to `mars.txt`.
 I can return to the previous version by typing `git checkout master~1 mars.txt`, and then
 committing those changes with a message like "I deleted the thing I just added".
 This will preserve your entire history, including the short-lived mistake, which will allow
 you to return to it if you should decide it wasn't a mistake at all.
 If you check out the entire repository using `git checkout master~1` you will be in
 "detached head state". This can be quickly remedied by typing `git checkout master`, to return
 you to the correct place. Detached head is when the head is not the same version as the master._


> ### Challenge {.challenge}
>
> Create a new Git repository on your computer called `bio`.
> Write a three-line biography for yourself in a file called `me.txt`,
> commit your changes,
> then modify one line and add a fourth and display the differences
> between its updated state and its original state.


## Episodes 
* [Introduction to Git](00-git-intro.md)
* [Creating a Repository and Tracking Files](01-git-setup-create-repo.md)
* [Exploring History and Reverting](03-exploring-hist.md)
* [Ignoring Files](04-ignoring-things.md)
* [Collaborating with GitHub](05-github-collab.md)
