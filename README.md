# PS5 KStuff Porting Tool Docker

Docker image that can execute [PS5 KStuff porting tool](https://github.com/sleirsgoevy/ps4jb-payloads/tree/bd-jb/ps5-kstuff/porting_tool).

## Requirements

- Docker
- Bash (optional)

## Executing

Enter the directory where this project is stored.

### Bash Method

```
./run.sh

# Optionally pass the required arguments
# ./run.sh <ps5_ip> <elf_loader_port> <fw_version>
```

Results will be stored in the current working directory inside a `results` directory.
The full path to the result directory will be output at the end of script execution.

### Manual Method

Create a directory on your system to store the results in, `<result_dir>`.

```
# Build the image with a given <tag>
docker build -t <tag> .

# Run the image mounting the result directory previously created
docker run -it --rm --mount type=bind,source="<result_dir>",target=/kstuff/results <tag>
```

Results will be stored in the `<result_dir>` you created.


## Versioning

[SemVer](http://semver.org/) is used for versioning.

## License

This project is licensed under the GNU GENERAL PUBLIC LICENSE V3 License.
See the [LICENSE.md](LICENSE) file for details

## Acknowledgments

* sleirsgoevy
* everyone else!

