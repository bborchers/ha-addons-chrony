# Home Assistant Add-on: Chrony

This add-on runs [Chrony](https://chrony-project.org/) as a time synchronization client for Home Assistant.
It keeps the host clock in sync with configurable upstream time servers and can enable NTS for secure time synchronization.

## Installation

1. Add the repository under Settings → Add-ons → Add-on Store → Repositories.
2. Find the "Chrony" add-on in the list and install it.
3. Adjust the configuration (see below).
4. Start the add-on.

## Configuration

Example configuration:

```yaml
servers:
  - pool.ntp.org
  - time.cloudflare.com
nts: true
```

### Option: `servers`

List of upstream time servers Chrony should use. If no server is configured, the add-on falls back to `pool.ntp.org`.

### Option: `nts`

Enable NTS (Network Time Security) for all configured time servers. Default: `false`.

If you enable NTS, make sure the configured servers support it.

## Support

If you run into problems, please open an issue in the [build repository](https://github.com/bborchers/ha-addons-chrony).
