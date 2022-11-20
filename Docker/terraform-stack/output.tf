output ins-id {
     value = aws_instance.myec2.id
}

output instance_type {
    value = aws_instance.myec2.instance_type
}

output public_ip {
    value = aws_instance.myec2.public_ip
}

output key_name {
    value = aws_instance.myec2.key_name
}