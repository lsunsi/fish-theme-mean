# mean theme

[![Build Status](https://travis-ci.org/lsunsi/fish-theme-mean.svg?branch=master)](https://travis-ci.org/lsunsi/fish-theme-mean)

A minimalistic single-line bilateral fish prompt theme.

- Left: No frills short prompt path
- Right: Sensibly color coded git information

## Installation

- `fisher lsunsi/fish-theme-mean`

## Git color code

The choices were made with two things in mind:

- Not all states need representation
  - Symbols are useful for representing all states
  - Choosing to ignore some states lowers cognitive load
- Represent important states on a common git workflow
  - Color will represent what it's important now
  - Colors should be meaningful to what it represents

What we came up to is:

1. You start your new branch, so it's clean and untracked.
2. You point it to some remote branch, so it's clean and tracked.
3. You start hacking some code on it, so it's dirty.
4. You commit your changes locally, so you're ahead.
5. You push your changes to remote, so you're clean again.
6. Someone makes some changes on remote, so you're behind.
7. You commit to on last change locally, so you diverged.
8. You force push to remote, and you're clean and done.

These states are currently being modelled like so:

State | Color
--- | ---
untracked | brblack
tracked | white
dirty | yellow
ahead | cyan
behind | magenta
diverged | red

## Development

- Clone this repository and get into it.
- Run `fisher .` to install local version.
- Run `fishtape tests/*` to test run all tests.
- Run `fisher rm mean` to remove it and get back to normal.

## Considerations

_This theme tries to hurt my feelings for no reason sometimes._
