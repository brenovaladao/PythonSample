from typing import Union
import librosa
import numpy as np

def get_timestamps_from_audio(audio_file_path: str = "") -> Union[np.array, int]:
    try:
        if not audio_file_path:
            return 0
        else:
            y, sr = librosa.load(audio_file_path)

            _, beats = librosa.beat.beat_track(y=y, sr=sr)

            return librosa.frames_to_time(beats, sr=sr)

    except Exception as e:
        return 0
