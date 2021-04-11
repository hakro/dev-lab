# Development lab

This Docker image comes preconfigured with a Vim config to make Go & Typescript development easy.

To use it, switch to your project directory, and run 

```console
docker run -it --name dev-lab -p 7000-7100:7000-7100 -v $PWD:/app hakimr/dev-lab bash
```
