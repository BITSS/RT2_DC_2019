---
title: Exploring History and Reverting
author: "Tim Dennis"
date: 2018-09-05
---

### Exploring History

* As we saw in the previous lesson, we can refer to commits by their identifiers. You can **refer to the most recent commit** of the working directory by using the identifier **HEAD**.

* We’ve been adding one line at a time to mars.txt, so it’s easy to track our progress by looking, so let’s do that using our HEADs. Before we start, let’s make a change to mars.txt.

~~~
$ nano mars.txt
~~~

add:

~~~
An ill-considered change
~~~

<kbd>control</kbd> <kbd>x</kbd>  to exit

~~~
$ cat mars.txt
~~~
{: .language-bash}

~~~
Cold and dry, but everything is my favorite color
The two moons may be a problem for Wolfman
But the Mummy will appreciate the lack of humidity
An ill-considered change
~~~

{: .output}

Now, let's see what we get.

~~~
$ git diff HEAD mars.txt
~~~
{: .language-bash}

~~~
diff --git a/mars.txt b/mars.txt
index b36abfd..0848c8d 100644
--- a/mars.txt
+++ b/mars.txt
@@ -1,3 +1,4 @@
 Cold and dry, but everything is my favorite color
 The two moons may be a problem for Wolfman
 But the Mummy will appreciate the lack of humidity
+An ill-considered change.
~~~
{: .output}

* Is this any different from what we'd get with `git diff mars.txt`?
* No it's the same as what you would get if you leave out HEAD (try it).
* The **real goodness** in all this is when you can refer to previous commits.
* We do that by adding ~1 (where “~” is “tilde”, pronounced [til-duh]) to refer to the commit one before HEAD.
* If we want to see what we changed when, we use `git diff` again, but refer to old versions
using the notation `HEAD~1`, `HEAD~2`, and so on:

~~~ {.bash}
$ git diff HEAD~1 mars.txt
~~~

~~~ {.output}
diff --git a/mars.txt b/mars.txt
index 315bf3a..b36abfd 100644
--- a/mars.txt
+++ b/mars.txt
@@ -1,2 +1,3 @@
 Cold and dry, but everything is my favorite color
 The two moons may be a problem for Wolfman
+But the Mummy will appreciate the lack of humidity
+An ill-considered change.
~~~

~~~ {.bash}
$ git diff HEAD~2 mars.txt
~~~

~~~
diff --git a/mars.txt b/mars.txt
index df0654a..b36abfd 100644
--- a/mars.txt
+++ b/mars.txt
@@ -1 +1,4 @@
 Cold and dry, but everything is my favorite color
+The two moons may be a problem for Wolfman
+But the Mummy will appreciate the lack of humidity
+An ill-considered change
~~~

* We could also use `git show`
* This shows us what changes we made at an older commit as well as the commit message, rather than the differences between a commit and our working directory that we see by using git diff.

~~~
git show HEAD~2 mars.txt
~~~

~~~
commit b33e7271ea67189f07a016824e967781f3e33d59
Author: Tim Dennis <dennis.tim@gmail.com>
Date:   Thu Sep 6 05:50:25 2018 -0700

    Starting to think about Mars

diff --git a/mars.txt b/mars.txt
new file mode 100644
index 0000000..df0654a
--- /dev/null
+++ b/mars.txt
@@ -0,0 +1 @@
+Cold and dry, but everything is my favorite color
~~~


* In this way we build up a chain of revisions.
* The most recent end of the chain is referred to as `HEAD`;
* we can refer to previous revisions using the `~` notation,
* so `HEAD~1` (pronounced "head minus one")
* means "the previous revision",
* while `HEAD~123` goes back 123 revisions from where we are now.

* We can also refer to revisions using
those long strings of digits and letters
that `git log` displays.
* These are unique IDs for the changes, and "unique" really does mean unique:
every change to any set of files on any machine
has a unique 40-character identifier.
* Our first commit was given the ID
`f22b25e3233b4645dabd0d81e651fe074bd8e73b`,
so let's try this
* let's use git log to find it.


~~~ {.bash}
$ git diff f22b25e3233b4645dabd0d81e651fe074bd8e73b mars.txt
~~~

~~~ {.output}
diff --git a/mars.txt b/mars.txt
index df0654a..b36abfd 100644
--- a/mars.txt
+++ b/mars.txt
@@ -1 +1,3 @@
 Cold and dry, but everything is my favorite color
+The two moons may be a problem for Wolfman
+But the Mummy will appreciate the lack of humidity
~~~

* That's the right answer, but typing random 40-character strings is annoying,
so Git lets us use just the first few:

~~~ {.bash}
$ git diff f22b25e mars.txt
~~~

~~~ {.output}
diff --git a/mars.txt b/mars.txt
index df0654a..b36abfd 100644
--- a/mars.txt
+++ b/mars.txt
@@ -1 +1,3 @@
 Cold and dry, but everything is my favorite color
+The two moons may be a problem for Wolfman
+But the Mummy will appreciate the lack of humidity
~~~

**Useful git diff flags**

* `git diff --stat` gives us a summary of the filename and number of insertions/deletions
* `git diff -- filename` looks at the differences for a specific file

### Recovering Old Versions

* So far, this seems like a lot of work.
* Why are we keeping track of all these little things??
* Let's say you are wolfman do some good work and go to bed and find in the morning you fatally ruin a file during an editing mistake
* Maybe you even accidentally delete an important file (This code is old, why should I keep it?).
* If you have version control, you don't need to track down your System Administrator. You can fix your problem

* Which leads us to **how** can we restore older versions of things?
* Let's suppose we accidentally overwrite our file:

~~~ {.bash}
$ nano mars.txt
~~~
open it and overwrite the file with:

~~~
We will need to manufacture our own oxygen
~~~

~~~
$ cat mars.txt
~~~

~~~ {.output}
We will need to manufacture our own oxygen
~~~

* our handy `git status` now tells us that the file has been changed,
but those changes haven't been staged:

~~~ {.bash}
$ git status
~~~

~~~ {.output}
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   **(use "git checkout -- <file>..." to discard changes in working directory)**
#
#	modified:   mars.txt
#
no changes added to commit (use "git add" and/or "git commit -a")
~~~

* We can put things back the way they were
by using `git checkout`:

~~~ {.bash}
$ git checkout HEAD mars.txt
$ cat mars.txt
~~~

~~~ {.output}
Cold and dry, but everything is my favorite color
The two moons may be a problem for Wolfman
But the Mummy will appreciate the lack of humidity
~~~

* As you might guess from its name, `git checkout` checks out (i.e., restores) an old version of a file.
* we're telling Git that we want to recover the version of the file recorded in `HEAD`,
which is the last saved revision.

**This would work even if we deleted our file, and wanted to get it back **
**delete mars.txt, and then show that it can be checked back out**

* If we want to go back even further,
we can use a revision identifier instead:

~~~ {.bash}
$ git checkout f22b25e mars.txt
~~~

* It's important to remember that we must use the **revision number** that identifies the state of the repository
*before* the change we're trying to undo.
* A common mistake is to use the revision number of the commit in which we made the change we're trying to get rid of.
* In the example below, we want retrieve the state from before the most
recent commit (`HEAD~1`), which is revision `f22b25e`:

<img src="https://swcarpentry.github.io/git-novice/fig/git-checkout.svg" alt="Git Checkout" />

* The following diagram illustrates what the history of a file might look
like (moving back from `HEAD`, the most recently committed version):

<img src="https://swcarpentry.github.io/git-novice/fig/git_staging.svg" alt="When Git Updates Revision Numbers" />

> #### Simplifying the Common Case
>
> If you read the output of `git status` carefully,
> you'll see that it includes this hint:
>
> ~~~ {.bash}
> (use "git checkout -- <file>..." to discard changes in working directory)
> ~~~
>
> As it says,
> `git checkout` without a version identifier restores files to the state saved in `HEAD`.
> The double dash `--` is needed to separate the names of the files being recovered
> from the command itself:
> without it,
> Git would try to use the name of the file as the revision identifier.

* The fact that files can be reverted one by one tends to change the way people organize their work.
* If everything is in one large document, it's hard (but not impossible) to undo changes to the introduction
without also undoing changes made later to the conclusion.
* If the introduction and conclusion are stored in separate files,
on the other hand,
moving backward and forward in time becomes much easier.
* Or for your code, if you store functions in files separate from code that executes them, or makes figures,
you can go back in time to find or retrieve specific chunks.

### Challenges

<https://swcarpentry.github.io/git-novice/05-history/index.html#recovering-older-versions-of-a-file>
