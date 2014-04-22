node default {
    include mcollective::server
}
node 'activemq.example.net' {
    include mcollective::activemq
    include mcollective::server
    include mcollective::client
}
