# lifeofguenter.nzbget

An Ansible role that compiles & configures NZBGet on Debian-like systems.

/usr/share/nzbget/nzbget.conf -> /home/nzb/.nzget
webuidirectory
configtemplate

## Requirements

_none_

## Role Variables

```yaml
nzbget_version: 23.0
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
