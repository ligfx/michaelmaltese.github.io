---
title: The Looping Problem, Using Python Iterators
layout: post
meta: Claremont
---

Let's look at the classic Looping Problem: given a singly-linked list, how do we tell if it loops or not? The naïve way is to keep track of every node you've already seen, but for fun let's do it in constant memory!

[There are a lot of solutions](http://ostermiller.org/find_loop_singly_linked_list.html), and I'm going to talk about two of them. You can check every node before the current one, or you can use a "tortoise and hare" method where one iterator iterates twice as fast as the other. The link above gives the algorithms in a pseudo-Java language, but in Python you can write them a lot more succinctly with iterators.

You should use iterators because they make the purpose of your code clearer. Does your code check loops, or increment `i` a bunch of times? The less extra cruft, the better (you probably already know this, which is why you use Python instead of C or Java).

Both of the following examples make use of the Python built-in module [itertools](http://docs.python.org/library/itertools.html), which provides lazy iterators and some other cool stuff. If you're not using it already, you should be!

## Solution 1: Check every node you've already seen

This solutions runs in O(N^2), but it's nice because it's easy to understand. For each node, we iterate through every node up to just before the current node, checking for matches. If we find any, then we have a loop.

In Python, you can use [itertools.islice](http://docs.python.org/library/itertools.html#itertools.islice) to lazily take the first n elements of a sequence. Combining this with the built-in [enumerate](http://docs.python.org/library/functions.html#enumerate), which adds indices to an iterator, you can write this algorithm as:

{% highlight python %}
from itertools import islice
def is_loop(node):
	for i, node in enumerate(seq):
		if node in islice(seq, i):
			return True
	return False
{% endhighlight %}

<br/>

## Solution 2: The tortoise and the hare

This one runs in O(N). You keep two iterators referencing the same linked-list, and advance one iterator faster than the other. If there's a loop, the faster iterator will loop around and catch up with the slower iterator.

In Python, the key is [itertools.izip](http://docs.python.org/library/itertools.html#itertools.izip), a lazy version of [the built-in function zip](http://docs.python.org/library/functions.html#zip). Zip constructs an iterator yielding an element from both sequences at the same time—for example, `zip([1,2], [a, b])` would give you `[(1,'a'), (2, 'b')]`. This algorithm needs the lazy version because if you do have a loop, then trying to construct a list will eventually make the Python interpreter run out of memory.

I also define a function `skip` that creates the fast iterator. It lazily yields the elements of a sequence, skipping n elements every time. Calling `skip(seq, 1)` gives you an iterator that goes twice as fast as a normal iterator.

The `skip` function also shows off some cool underlying features of Python:

The [iter](http://docs.python.org/library/functions.html#iter) function turns any collection into an iterator, so all you have to give `skip` is some object which supports [the iteration protocol](http://docs.python.org/reference/datamodel.html#object.__iter__). Any object with an `__iter__` method can be turned into an iterator.

You might be curious about the infinite while loop—what happens when it reaches the end of the list? When an iterator runs out of available elements, it raises the [StopIteration](http://docs.python.org/library/exceptions.html#exceptions.StopIteration) exception. Since the `skip` function doesn't catch it, it's essentially as though it raises the exception itself, which is exactly what it's supposed to do when it reaches the end of the list.

Here's the solution:

{% highlight python %}
def skip(seq, n):
	seq = iter(seq)
	while True:
		yield next(seq)
		for i in xrange(n):
			next(seq)

from itertools import izip
def is_loop(seq):
    for slow_node, fast_node in izip(seq, skip(seq, 1)):
        if slow_node == fast_node:
            return True
    return False
{% endhighlight %}

<br/>