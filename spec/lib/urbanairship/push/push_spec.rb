require 'spec_helper'

require 'urbanairship/push/push'
require 'urbanairship/push/payload'

include Urbanairship::Push
include Urbanairship::Push::Payload

describe Push do
  describe '#payload' do
    it 'can build a full payload structure' do
      p = Push.new(nil)
      p.audience = all_
      p.notification = notification(alert: 'Hello')
      p.options = options(expiry: 10080)
      p.device_types = all_
      p.message = message(
        title: 'Title',
        body: 'Body',
        content_type: 'text/html',
        content_encoding: 'utf8',
        extra: { more: 'stuff' },
        expiry: 10080,
        icons: { list_icon: 'http://cdn.example.com/message.png' },
        options: { some_delivery_option: true }
      )

      expect(p.payload).to eq({
        audience: 'all',
        notification: {alert: 'Hello'},
        device_types: 'all',
        options: { expiry: 10080 },
        message: {
          title: 'Title',
          body: 'Body',
          content_type: 'text/html',
          content_encoding: 'utf8',
          extra: {more: 'stuff'},
          expiry: 10080,
          icons: { list_icon: 'http://cdn.example.com/message.png' },
          options: { some_delivery_option: true },
        }}
      )
    end

    it 'can build a payload with actions' do
      p = Push.new(nil)
      p.audience = all_
      p.notification = notification(
        alert: 'Hello',
        actions: actions(
          add_tag: 'new_tag',
          remove_tag: 'old_tag',
          share: 'Check out Urban Airship!',
          open_: {
              type: 'url',
              content: 'http://www.urbanairship.com'
          },
          app_defined: {some_app_defined_action: 'some_values'}
        )
      )
      p.options = options(expiry: 10080)
      p.device_types = all_
      p.message = message(
        title: 'Title',
        body: 'Body',
        content_type: 'text/html',
        content_encoding: 'utf8',
        extra: { more: 'stuff' },
        expiry: 10080,
        icons: { list_icon: 'http://cdn.example.com/message.png' },
        options: { some_delivery_option: true }
      )

      expect(p.payload).to eq({
        audience: 'all',
        notification: {
          alert: 'Hello',
          actions: {
            add_tag: 'new_tag',
            remove_tag: 'old_tag',
            share: 'Check out Urban Airship!',
            open: {
              type: 'url',
              content: 'http://www.urbanairship.com'
            },
            app_defined: {some_app_defined_action: 'some_values'}
          }},
        device_types: 'all',
        options: { expiry: 10080 },
        message: {
          title: 'Title',
          body: 'Body',
          content_type: 'text/html',
          content_encoding: 'utf8',
          extra: {more: 'stuff'},
          expiry: 10080,
          icons: { list_icon: 'http://cdn.example.com/message.png' },
          options: { some_delivery_option: true },
        }}
      )
    end
  end
end
