"""
Script with valueable Python functions for project Filminit.
"""

from typing import Union
import librosa
import numpy as np

def get_timestamps_from_audio(audio_file_path: str = "") -> Union[np.array, int]:
    """Extract timestamps from audio file. Inspired by
    https://librosa.org/doc/main/generated/librosa.beat.beat_track.html
​
    Parameters
    ----------
    audio_file_path: str
        Path into stored audio file. Default empty string.
​
    Returns
    ------
    np.array
        Numpy array with timestamps of beats.
    """

    try:
        if not audio_file_path:
            return 1_001
        else:
            y, sr = librosa.load(audio_file_path)

            _, beats = librosa.beat.beat_track(y=y, sr=sr)

            return librosa.frames_to_time(beats, sr=sr)

    except FileNotFoundError:
        return 1_002

    except ValueError:
        return 1_003

    except Exception as e:
        return 1_000
