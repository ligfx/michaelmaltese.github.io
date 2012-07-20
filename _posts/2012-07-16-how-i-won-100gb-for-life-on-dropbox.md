---
title: How I Won 100GB For Life On Dropbox
layout: post
meta: San Francisco
---

![](/images/photo-hack-day.jpg)

Last Saturday and Sunday I attended [Photo Hack Day 3](http://www.photohackday.org/), at the Dropbox headquarters. A bunch of awesome photo and video API producers sponsored it, including Facebook, Flickr, Tumblr, Dropbox, and Walgreens (who provided the snacks, thanks Walgreens!). Each sponsor had a prize for their favorite hack.

Dropbox was also giving away 10GB for life to anyone who used their API, so I put together a small app. My app *Fieldbox*, which displayed Camera Uploads from their mobile app for multiple users at once, ended up winning the top Dropbox prize: 100GB for life! 

Here are some things I think I did well:

## Solve a real problem

The idea for Fieldbox came out of a situation that's frustrated me before. Imagine you're a news media organization, and an event happens that you want to cover in real time. Some reporters are there with smartphones, but how do they quickly and easily get the photos to an editor to post with an article?

The Dropbox mobile app has this awesome feature where 1. You open it, and 2. It uploads all of your photos and videos to Dropbox. Quick and easy!

Fieldbox would allow someone on a computer to see all of the photos being uploaded, in quasi-realtime. Much better than the current situation.

## Concentrate on the minimum viable product

I hard-coded OAuth tokens into the code. There, I confess! In multiple places, no less. An 12-hour prototype doesn't need user management or authentication hooks.

A usable product requires a lot of things that a prototype doesn't, so don't waste time making features that don't matter.

## Stay up for thirty-six hours

I'm kidding, this is [a terrible idea](http://healthysleep.med.harvard.edu/).

We also picked up some leftover snacks from Walgreens. Did I mention how awesome they are?

Ideas on what to do with 100GB of cloud storage now being accepted.