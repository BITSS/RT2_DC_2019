---
title: Creating a Repository and Tracking Files
date: 2018-09-05
authore: "Tim Dennis"
---

## Tracking Changes to Files

* Let's create a file called `mars.txt` that contains some notes
about the Red Planet's suitability as a base.
* (We'll use `nano` to edit the file; you can use whatever editor you like.
* In particular, this does not have to be the core.editor you set globally earlier.)

_also create a second file named venus.txt_

~~~ {.bash}
$ nano mars.txt
~~~

Type the text below into the `mars.txt` file:

~~~ {.bash}
Cold and dry, but everything is my favorite color
~~~

`mars.txt` now contains a single line:

~~~ {.bash}
$ ls
~~~

~~~ {.output}
mars.txt
~~~

~~~ {.bash}
$ cat mars.txt
~~~

~~~ {.output}
Cold and dry, but everything is my favorite color
~~~

If we check the status of our project again,
Git tells us that it's noticed the new file:

~~~ {.bash}
$ git status
~~~

~~~ {.output}
# On branch master
#
# Initial commit
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	mars.txt
nothing added to commit but untracked files present (use "git add" to track)
~~~

__highlight the "Untracked files" section and that git tells you how to add a file to the next commit.__

* The "untracked files" message means that there's a file in the directory that Git isn't keeping track of.

**Now, lets add files that are inside:**
1. On the white board draw a box representing the **staging area** (index) and explain that this is where we set up the next snapshot of our project.
1. Like a **photographer in a studio**, we're putting together a shot before we actually snap the picture.
1. Connect the working area box and the staging box with 'git add'._

* Note: we can use `git add .` - This adds __all__ the files in our repository.
* But sometimes we only want to add a single file at a time.

>## why would you want to add individual files or a select group files and not all?
> * batching connected work - say you are working on multiple files, but only two are part of a unit-of-work
> * you can add those files to stage for commit together

* We can tell Git that it should do so using `git add`:

~~~ {.bash}
$ git add mars.txt
~~~

and then check that the right thing happened:

~~~ {.bash}
$ git status
~~~

~~~ {.output}
# On branch master
#
# Initial commit
#
# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
#
#	new file:   mars.txt
#
~~~

* Git now knows that it's supposed to keep track of `mars.txt`,
but it hasn't yet recorded any changes for posterity as a commit.

* Let's tell git _"Hey, we want you to remember the way that the files look right now"_.
* To commit to our repo, we need to run one more command:

~~~ {.bash}
$ git commit -m "Starting to think about Mars"
~~~

~~~ {.output}
[master (root-commit) f22b25e] Starting to think about Mars
 1 file changed, 1 insertion(+)
 create mode 100644 mars.txt
~~~

* When we run `git commit`, Git takes everything we have told it to save by using `git add` and stores a copy permanently inside the special `.git` directory.
* This permanent copy is called a [revision](../../gloss.html#revision) and its short identifier is `f22b25e`.
(Your revision may have another identifier.)

* We use the `-m` flag (for "message") to record a comment that will help us remember later on what we did and why.
* If we just run `git commit` without the `-m` option, Git will launch `nano` (or whatever other editor we configured at the start) so that we can write a longer message.
* **You must have a commit message**. It's good practice and git won't let you commit without one.

* NOTE: If you only want to add one file, use `git commit filename.txt -m "message"`
`git commit -am "message"` will add ALL tracked files.

**On the white board draw a box representing the project history.**

1. Once we take a snapshot of the project that snapshot becomes a permanent reference point in the project's history that we can always go back to.
2. The history is like a **photo album of changes**, and each snapshot has a **time stamp**, the **name of the photographer**, and a **description**.
3. Connect the staging area to the history with **`git commit -m "message"`**.
4. In order to save a snapshot of the current state (revision) of the repository, we use the commit command.
5. This command is always associated with a message describing the changes since the last commit and indicating their purpose.
6. Git will ask you to add a commit message. This is just to remind you what changes you made.
7. Informative commit messages will serve you well someday, so make a habit of never committing changes without at least a full sentence description.

__ADVICE: Commit often__

* In the same way that it is wise to often save a document that you are working on, so too is it wise to save numerous revisions of your code.
* More frequent commits increase the granularity of your undo button. If you commit every 1, you have an hour undo button, if you commit every day, you'll have a day's long undo button.
* There are no hard and fast rules, but good commits are atomic: they are the smallest change that remain meaningful.
* A good commit message usually contains a one-line description followed by a longer explanation if necessary.

__ADVICE: Good commit messages__

[because it's important!](http://www.commitlogsfromlastnight.com/)

* For code, it's useful to commit changes that can be reviewed by someone in under an hour.
* Or it can be useful to commit changes that "go together" - for example, one paragraph of a manuscript, or each new function added to your script.
* For example:
  * if you work on your code all day long (add 200 lines of code, including 5 new functions and write 7 pages of your new manuscript including deleting an old paragraph),
  * and at 3:00 you make a fatal error or deletion, but you didn't commit once, then you will have a hard time recreating the version you are looking for - because it doesn't exist!


If we run `git status` now:

~~~ {.bash}
$ git status
~~~

~~~ {.output}
# On branch master
nothing to commit, working directory clean
~~~

* it tells us everything is up to date. this is great!
* If we want to know what we've done recently, we can ask Git to show us the project's history using `git log`.

* You can see all the changes you have ever made using this command:

~~~ {.bash}
$ git log
~~~

~~~ {.output}
commit f22b25e3233b4645dabd0d81e651fe074bd8e73b
Author: Vlad Dracula <vlad@tran.sylvan.ia>
Date:   Thu Aug 22 09:51:46 2013 -0400

    Starting to think about Mars
~~~

* `git log` lists all revisions  made to a repository in **reverse chronological order**.
* The listing for each revision includes the revision's full identifier (which starts with the same characters as
the short identifier printed by the `git commit` command earlier),
the revision's author,
when it was created,
and the log message Git was given when the revision was created.

> #### Where Are My Changes?
>
> If we run `ls` at this point, we will still see just one file called `mars.txt`.
> That's because Git saves information about files' history
> in the special `.git` directory mentioned earlier
> so that our filesystem doesn't become cluttered
> (and so that we can't accidentally edit or delete an old version).

### Changing a File

Now suppose Dracula adds more information to the file.

(Again, we'll edit with `nano` and then `cat` the file to show its contents;
you may use a different editor, and don't need to `cat`.)

~~~ {.bash}
$ nano mars.txt
~~~
add:
~~~
The two moons may be a problem for Wolfman
~~~

~~~
$ cat mars.txt
~~~

~~~ {.output}
Cold and dry, but everything is my favorite color
The two moons may be a problem for Wolfman
~~~

* When we run `git status` now,
it tells us that a file it already knows about has been modified:

~~~ {.bash}
$ git status
~~~

~~~ {.output}
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#	modified:   mars.txt
#
no changes added to commit (use "git add" and/or "git commit -a")
~~~

* The last line is the key phrase: "no changes added to commit".
* We have changed this file, but we haven't told Git we will want to save those changes
(which we do with `git add`) much less actually saved them.
* Let's double-check our work using `git diff`, which shows us the differences between
the current state of the file
and the most recently saved version:

~~~ {.bash}
$ git diff
~~~

~~~ {.output}
diff --git a/mars.txt b/mars.txt
index df0654a..315bf3a 100644
--- a/mars.txt
+++ b/mars.txt
@@ -1 +1,2 @@
 Cold and dry, but everything is my favorite color
+The two moons may be a problem for Wolfman
~~~

* The output is cryptic because it is actually a **series of commands for tools like editors and `patch`**
telling them how to reconstruct one file given the other.
* If we can break it down into pieces:

1.  The first line tells us that Git is producing output similar to the Unix `diff` command
    comparing the old and new versions of the file.
2.  The second line tells exactly which [revisions](../../gloss.html#revision) of the file
    Git is comparing;
    `df0654a` and `315bf3a` are unique computer-generated labels for those revisions.
3.  The remaining lines show us the actual differences
    and the lines on which they occur.
    In particular,
    the `+` markers in the first column show where we are adding lines.

* Let's commit our change:

~~~ {.bash}
$ git commit -m "Concerns about Mars's moons on my furry friend"
~~~

~~~ {.output}
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#	modified:   mars.txt
#
no changes added to commit (use "git add" and/or "git commit -a")
~~~

* Whoops:
* Git won't commit because we didn't use `git add` first.

Let's fix that:

~~~ {.bash}
$ git add mars.txt
$ git commit -m "Concerns about Mars's moons on my furry friend"
~~~

~~~ {.output}
[master 34961b1] Concerns about Mars's moons on my furry friend
 1 file changed, 1 insertion(+)
~~~

* Git insists that we add files to the **set** we want to commit
before actually committing anything
because we may not want to commit everything at once.
* This allows us to commit our changes in stages and capture changes in logical portions rather than only large batches.
* Think about the size of the <kbd>undo</kbd> button
*  For example, suppose we’re adding a few citations to relevant research to our thesis.
* We might want to commit those additions, and the corresponding bibliography entries, but not commit some of our work drafting the conclusion (which we haven’t finished yet).

* To allow for this,
Git has a special staging area
where it keeps track of things that have been added to
the current [change set](../../gloss.html#change-set)
but not yet committed.
* `git add` puts things in this area, and `git commit` then copies them to long-term storage (as a commit):

<img src="https://git-scm.com/book/en/v2/images/areas.png" alt="The Git Staging Area" />

* Let's watch as our changes to a file move from our editor to the staging area
and into long-term storage.
* First,
we'll add another line to the file:

~~~ {.bash}
$ nano mars.txt
~~~
add:
~~~
But the Mummy will appreciate the lack of humidity
~~~
~~~
$ cat mars.txt
~~~

~~~ {.output}
Cold and dry, but everything is my favorite color
The two moons may be a problem for Wolfman
But the Mummy will appreciate the lack of humidity
~~~

~~~ {.bash}
$ git diff
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
~~~

* So far, so good: we've added one line to the end of the file
(shown with a `+` in the first column).
* Now let's put that change in the staging area
and see what `git diff` reports:

~~~ {.bash}
$ git add mars.txt
$ git diff
~~~

* There is no output: as far as Git can tell,
there's no difference between what it's been asked to save permanently
and what's currently in the directory.
* However, if we do this:

~~~ {.bash}
$ git diff --staged
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
~~~

it shows us the difference between
the last committed change
and what's in the staging area.
Let's save our changes:

~~~ {.bash}
$ git commit -m "Thoughts about the climate"
~~~

~~~ {.output}
[master 005937f] Thoughts about the climate
 1 file changed, 1 insertion(+)
~~~

check our status:

~~~ {.bash}
$ git status
~~~

~~~ {.output}
# On branch master
nothing to commit, working directory clean
~~~

and look at the history of what we've done so far:

~~~ {.bash}
$ git log
~~~

~~~ {.output}
commit 005937fbe2a98fb83f0ade869025dc2636b4dad5
Author: Vlad Dracula <vlad@tran.sylvan.ia>
Date:   Thu Aug 22 10:14:07 2013 -0400

    Thoughts about the climate

commit 34961b159c27df3b475cfe4415d94a6d1fcd064d
Author: Vlad Dracula <vlad@tran.sylvan.ia>
Date:   Thu Aug 22 10:07:21 2013 -0400

    Concerns about Mars's moons on my furry friend

commit f22b25e3233b4645dabd0d81e651fe074bd8e73b
Author: Vlad Dracula <vlad@tran.sylvan.ia>
Date:   Thu Aug 22 09:51:46 2013 -0400

    Starting to think about Mars
~~~

_Useful `git log` flags:_

* -3 (shows only the 3 most recent commits)
* --oneline (condenses each log into a single line, for quicker scanning)
* --stat (gives more details for each commit, ++--)
* --since=X.minutes/hours/days/weeks/months/years or YY-MM-DD-HH:MM (for specific time frames)
* --author=<pattern> (look for specific people)

<https://swcarpentry.github.io/git-novice/04-changes/index.html#choosing-a-commit-message>

To recap, when we want to add changes to our repository,
we first need to add the changed files to the staging area
(`git add`) and then commit the staged changes to the
repository (`git commit`):

<img src="https://swcarpentry.github.io/git-novice/fig/git-committing.svg" alt="The Git Commit Workflow" />

## Episodes

* [Introduction to Git](00-git-intro.md)
* [Creating a Repository and Tracking Files](01-git-setup-create-repo.md)
* [Exploring History and Reverting](03-exploring-hist.md)
* [Ignoring Files](04-ignoring-things.md)
* [Collaborating with GitHub](05-github-collab.md)
