bashrc
======

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc/generate-toc again -->
**Table of Contents**

- [bashrc](#bashrc)
    - [Summary](#summary)
    - [Features](#features)

<!-- markdown-toc end -->

## Summary

Bash config file `.bashrc` can get messy pretty quickly if proper care
is not taken to keep code properly modularized and clean. Also, it is
desirable to be able load the configuration in short amount of
time. Furthermore, it should be easier to debug your configuration and
get some metrics regarding how much time is being spent to load
different modules.

## Features

To be able to do everything mentioned above and more, following features
are implemented in this configuration:

- Ability to load a config on demand along with a metric of time spent
  in loading

- Enabled `dircolors`

- Setup helpful aliases for docker

- Setup prompt with colors wherein each color can give information like
  system load etc.

- Shorten the path in prompt if it gets too long


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/anshulverma/bashrc/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

