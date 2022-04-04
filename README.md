# container-namespaces
Check docker container isolation based on namespaces.

[![GitHub license](https://img.shields.io/github/license/hosein-yousefii/container-namespaces)](https://github.com/hosein-yousefii/container-namespaces/blob/master/LICENSE)
![LinkedIn](https://shields.io/badge/style-hoseinyousefi-black?logo=linkedin&label=LinkedIn&link=https://www.linkedin.com/in/hoseinyousefi)

This script shows which containers' namespaces are equal to host namespaces.

## What is Namespace?

Namespaces are a feature of the Linux kernel that partitions kernel resources such that one set of processes sees one set of resources while another set of processes sees a different set of resources. The feature works by having the same namespace for a set of resources and processes, but those namespaces refer to distinct resources.

## Usage:

On docker host execute:

```
./dockerns.sh
```

## Contribute

In case of any useful Idea You are able to make a pull request. Do not hesitate to ask any question.

Copyright 2021 Hosein Yousefi <yousefi.hosein.o@gmail.com>

