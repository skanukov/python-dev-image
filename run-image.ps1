docker run --name=python-dev-container -d -t `
  -v D:\Dev\Projects\Docker\python-dev-image\shared:/home/docker `
  -p 8000:8000 `
  python-dev-image
