# Homebrew Ensembl

Core formula for creating and installing Ensembl dependencies.

## Homebrew/Linuxbrew compatability
These formula have been developed primarily for Linuxbrew. They may work for OSX, they may not. If you are unsure then look at [Homebrew Science](https://github.com/Homebrew/homebrew-science) for more generic solutions.

## How Do I Install these Formula
`brew install ensembl/ensembl/<formula>`

Or brew tap `ensembl/ensembl` and then `brew install <formula>`.

## Troubleshooting
**IMPORTANT** First read the [Troubleshooting Checklist](https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Troubleshooting.md#troubleshooting).).

Use `brew gist-logs <formula>` to create a [Gist](https://gist.github.com/) and post the link in your issue.

Search [open](https://github.com/ensembl/homebrew-ensembl/issues?state=open) and [closed](https://github.com/ensembl/homebrew-ensembl/issues?state=closed) issues. See also Homebrew's  [Common Issues](https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Common-Issues.md) and [FAQ](https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/FAQ.md).

## Documentation
`brew help`, `man brew` or check [Homebrew's documentation](https://github.com/Homebrew/brew/tree/master/share/doc/homebrew#readme).

## Contributing
There is no guide for this at the moment

# Common Errors From Compiled Binaries

## libgcc and pthread

```
libgcc_s.so.1 must be installed for pthread_cancel to work
```

Solved by https://github.com/Linuxbrew/homebrew-core/pull/2622 where `ligcc_s.so.1` is symlinked in to where glibc can find it. If this does appear again though recompiling the affected formula from source (e.g. `brew reinstall -s bwa`) would work.

## examl

```
unable to open mca_ess_lsf: libbat.so: cannot open shared object file: No such file or directory
```

Indicates a lack of the LSF `libbat.so` module on your path. Export LSF's libraries onto your `LD_LIBRARY_PATH`.

## Incompatible GLIBC_VERSION

```
“version `GLIBC_2.14' not found”
```

Happens when two binaries have been compiled with different glibc's (more likely different versions of GCC with different versions of glibc). The common error is compiling on a younger version and trying to link back to an older version. Solution is find out where the cross-compile happened and stop it.
