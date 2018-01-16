module ViewHelpers
  def request_mock(options={})
    options.reverse_merge! env: {}, host: 'test.dev', path_info: '', port: 80, protocol: 'http://'

    env = { 'action_dispatch.request.query_parameters' => {} }.merge options[:env]

    request = double()

    allow(request).to receive_messages(
        protocol: options[:protocol],
        host: options[:host],
        port: options[:port],
        path_info: options[:path_info],
        env: env)

    return request
  end
end
