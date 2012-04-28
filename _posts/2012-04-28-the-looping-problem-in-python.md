---
title: The Looping Problem, Using Python Iterators
layout: post
meta: Claremont
---

Let's look at the classic Looping Problem: given a singly-linked list, how do we tell if it loops or not? The naïve way is to keep track of every node you've already seen, but for fun let's do it in constant memory.

[There are a lot of solutions](http://ostermiller.org/find_loop_singly_linked_list.html), but I think two are particularly simple and elegant. You can check every node before the current one, or you can use a "tortoise and hare" method where one iterator iterates twice as fast. That link gives the algorithms in a pseudo-Java language, but in Python you can write them a lot more succinctly with iterators.

Why iterators? Python provides these nice abstractions so we don't have to worry about the low-level crap in our programs. Sure, you could bother keeping track of `while` loops and call `nextNode()` manually, but using these features lets you express more accurately what the algorithm is doing. You don't have to worry about incrementing `i` and `j` variables inside loops, you just figure out if a list loops or not.

Both of these examples make use of the Python built-in module `itertools`, which provides lazy iterators and some other cool stuff. If you're not using it already, you should be.

## Solution 1: Check every node we've already seen

This solutions runs in O(N^2), but it's nice because it's easy to understand. For each node, we iterate through every node up to just before the current node, checking if any match. If they do, we have a loop.

In Python, you can use the `itertools.islice(seq, n)` function to lazily take the first n elements of a sequence. Combining this with the built-in `enumerate(seq)`, which adds indices to an iterator, you can write this algorithm as:

{% highlight python %}
from itertools import islice
def is_loop(node):
	for i, node in enumerate(seq):
		if node in islice(seq, i):
			return True
	return False
{% endhighlight %}

Nice and pretty.

## Solution 2: The tortoise and the hare

This solution runs in O(N). You keep two iterators referencing the same linked-list, and advance one iterator faster than the other. If there is a loop, the faster iterator will loop around and catch up with the slower iterator.

In Python, the key function is `itertools.izip(seq_a, seq_b)`, a lazy version of the built-in function `zip`. Zip constructs an iterator yielding the i-th element of both sequences at the same time—for example, `zip([1,2], [a, b])` would give you `[(1,'a'), (2, 'b')]`. This algorithm needs the lazy version because we might have a loop, and trying to construct a list will eventually cause your Python interpreter to run out of memory.

I also use a function `chunk` which looks pretty weird. Don't worry, it just clusters the sequence into n-length tuples, like the [standard library docs say](http://docs.python.org/library/functions.html#zip).

{% highlight python %}
from itertools import izip
def chunk(seq, n):
    return izip(*[iter(seq)]*n)

def is_loop(seq):
    for slow_node, fast_node_pair in izip(seq, chunk(seq, 2)):
        if slow_node in fast_node_pair:
            return True
    return False
{% endhighlight %}