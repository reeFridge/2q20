extends Sprite

export(Array, Texture) var textures = []
export(Array, int) var episode_masks = []
	
func before_enter():
	var episode = Stats.episode
	var texture_idx = episode_masks.find(episode)

	while episode != 0 && texture_idx == -1:
		episode -= 1
		texture_idx = episode_masks.find(episode)

	if texture_idx == -1:
		texture = textures[0]
	else:
		texture = textures[texture_idx]
