# Install, configure, and test
sudo apt update && sudo apt install git -y && \
git config --global user.name "Your Name" && \
git config --global user.email "your.email@example.com" && \
ssh-keygen -t ed25519 -C "your.email@example.com" -f ~/.ssh/id_ed25519 -N "" && \
eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_ed25519 && \
echo "SSH Public Key:" && cat ~/.ssh/id_ed25519.pub

