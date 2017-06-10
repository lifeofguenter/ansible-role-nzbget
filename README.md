[![Build Status](https://travis-ci.org/lifeofguenter/ansible-role-nzbget.svg?branch=master)](https://travis-ci.org/lifeofguenter/ansible-role-nzbget)

# Ansible Role: NZBGet

An Ansible role that installs NZBGet (from source) on Debian like systems.

## Requirements

none

## Role Variables

- `nzbget_version: 18.1`
- `nzbget_user: nzbget`

## Dependencies

none

## Example Playbook

    - hosts: nvr
      roles:
        - { role: lifeofguenter.nzbget }

## License

MIT
