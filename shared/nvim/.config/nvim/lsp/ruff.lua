return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = {
    "main.py",
    "pyproject.toml",
    "setup.py",
    "requirements.txt",
  },
}
