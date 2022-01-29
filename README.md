# lifeofguenter.nzbget

[![Build Status](https://travis-ci.com/lifeofguenter/ansible-role-nzbget.svg?branch=main)](https://travis-ci.com/lifeofguenter/ansible-role-nzbget)

An Ansible role that compiles & configures NZBGet on Debian-like systems.

## Requirements

_none_

## Role Variables

```yaml
nzbget_version: 21.1
nzbget_user: nzb
```

## Dependencies

none

## Example Playbook

```yaml
- hosts: media-center
  roles:
    - { role: lifeofguenter.nzbget }
```

## License

**MIT**, see the [LICENSE file](LICENSE) for details.

## Author Information

[Günter Grodotzki](https://www.lifeofguenter.de)
