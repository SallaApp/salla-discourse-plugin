# Salla Serializers Discourse Plugin

## Overview

**salla_serializers** is a Discourse plugin that extends and customizes the default serializers and controllers to provide additional data and behavior for Salla's community forum integration. It introduces new attributes to various serializers, customizes API responses, and adds new endpoints for enhanced forum functionality.

## Features

- **Extended Serializers:**
  - Adds new attributes to `BasicCategorySerializer`, `PostSerializer`, `SuggestedTopicSerializer`, and `TopicListItemSerializer`.
  - Includes custom fields such as `only_admin_can_post`, `emoji`, `topic_creator`, `first_post_details`, and more.
- **Controller Extensions:**
  - Modifies API responses to remove sensitive user data unless accessed by an admin.
  - Adds logic to filter out certain keys from responses for privacy.
- **Custom Middleware Patch:**
  - Ensures API username headers are properly resolved to usernames.
- **Custom Routes and Controllers:**
  - Adds a new endpoint: `POST /t/:id/increment_count` to increment topic view counts.
- **Tag Controller Patch:**
  - Enhances tag filtering options in topic lists.

## Installation

1. Clone or download this repository into your Discourse `plugins` directory:
   ```sh
   git clone <repository-url> plugins/salla_serializers
   ```
2. Rebuild your Discourse application:
   ```sh
   ./launcher rebuild app
   ```

## Configuration

The plugin can be enabled or disabled via site settings:

- **Setting:** `salla_serializers_enabled`
- **Default:** `true`
- **Location:** Admin > Settings > Plugins

## Usage

### Extended Serializers
- The plugin automatically extends the following serializers:
  - `BasicCategorySerializer`
  - `PostSerializer`
  - `SuggestedTopicSerializer`
  - `TopicListItemSerializer`
- These serializers now include additional fields such as `emoji`, `only_admin_can_post`, and user-related details.

### Custom Endpoint
- **Increment Topic View Count:**
  - `POST /t/:id/increment_count`
  - Increments the view count for a topic. Used for custom analytics or integrations.

### API Response Filtering
- Non-admin API responses will have sensitive user fields (`admin`, `moderator`, `trust_level`, and the `users` key) removed for privacy.

## Development

- Main plugin logic is in `plugin.rb`.
- Serializer extensions are in `app/serializers/`.
- Controller and middleware patches are in `lib/salla_serializers/`.
- Custom controller is in `app/controllers/`.
- Routes are defined in `app/config/routes.rb`.
- Plugin settings are in `config/settings.yml`.

## Authors
- Ahsan Afzal