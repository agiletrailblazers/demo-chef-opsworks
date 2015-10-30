@test "manager is installed" {
    [ -d "/usr/share/tomcat8/webapps/manager" ]
}

@test "password is set" {
    run grep "testpassword" /etc/tomcat8/tomcat-users.xml
    [ "$status" -eq 0 ]
}

@test "username is set" {
    run grep "deployuser" /etc/tomcat8/tomcat-users.xml
    [ "$status" -eq 0 ]
}
