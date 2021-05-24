# Development lab

This Docker image comes preconfigured with a Vim config to make Go & Typescript development easy.

To use it, switch to your project directory, and run 

```console
docker run -it --name dev-lab -p 7000-7005:7000-7005 -v $PWD:/app hakimr/dev-lab bash
```

## Useful commands & Shortcuts

- Open a terminal : `:term`
- Swap Split positions : `ctrl+W R`
- Move to new split : `ctrl+W W`
- Move to the split above : `ctrl+W K`
- Move to the split below : `ctrl+W J`
- Toogle NERDTree : `:NERDTreeToggle`
- Scroll in termainl : `ctrl+W Shift+N` Then use J&K to navigate, and i to go back
