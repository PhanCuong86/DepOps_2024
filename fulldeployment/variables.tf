variable "aws-region" {
    default = "ap-southeast-2"
}

variable "cidr-block" {
    default = "10.0.0.0/16"
}

variable "ami" {
    default = "ami-0809dd5035d9217b8"
}

variable instance-type {
    default = "t2.micro"
}

variable public-key {
    default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDNSltfh98MfxnEoIR2ilhagAyPtDxeM2EAtSanvFo+VEKc+aP3viac9CJU6s5o7kmGD9jTjmWWZ9DvumV5IBvDAs1r7f+4C/MOV1cD39+ifBid4UvZhPMrBipv/IoNVwYO5Rhz8qGe7emUx+C30SlTacdpI8PN0lT+MokLIdwwZZneIE9nDEzaFrFczNVXjASAzslPiO9wdd8y0fp1qfF9kh8jM2wWt2LVIMb7tELax7hh+SZTJb2zO8x2cgVXI7ec6QfV98fofFDe8VT0LLuLa1fwiKWavnUoLXKvuQVxuIyt5YPE2CM5M59VUMZF9omFKXHHRpWp5901nBChU7ISQ7UVHWf4jsqDTfxE/+9oei8PMcmWMwGzC54ENFsYf57FmvnndJV1XKZbuTYI0Mic3Vkt9RrrZmPb64chuwYyaT3sTPtWQ2M9Cs2YdR/gX+dg3ar6A1jBt17FtmIoZTBK+LRmeguI7zyJD1nWxpFfS5+extji0t/VIOTt0eLt728 rsa-key-20240802"
}